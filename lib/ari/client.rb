require 'net/http'
require 'multi_json'
require 'ari/request_error'
require 'ari/server_error'
require 'event_emitter'
require 'websocket-client-simple'

module Ari
  class Client
    include EventEmitter

    attr_reader :ws

    DEFAULTS = {
      :url => 'http://localhost:8088/ari'
    }

    HTTP_HEADERS_BASE = {
      'Content-Type'    => 'application/json',
      'User-Agent'      => "asterisk-ari-client/#{::Asterisk::Ari::Client::VERSION} ruby/#{RUBY_VERSION}"
    }

    HTTP_HEADERS = HTTP_HEADERS_BASE.merge(
      'Accept'          => 'application/json',
      'Accept-Charset'  => 'utf-8',
    )

    def initialize(options = {})
      @options = DEFAULTS.merge options
      @uri = URI.parse @options[:url]
      raise ArgumentError.new("The :api_key needs to be specified.") unless @options[:api_key]
    end

    %w{ get put post delete }.each do |http_method|
      method_klass = Net::HTTP.const_get http_method.to_s.capitalize
      define_method http_method do |path, params = {}|
        query_params = params.except(:client, :headers, :body)
        query_params.merge!({ api_key: @options[:api_key], app: @options[:app] })
        query_string = URI.encode_www_form query_params
        request_path = "#{@uri.path}#{path}?#{query_string}"
        request = method_klass.new(request_path, params[:headers] || HTTP_HEADERS)
        request.body = params[:body].is_a?(Hash) ? MultiJson.dump(params[:body]) : params[:body]
        send_request request
      end
    end

    def connect_websocket
      params = { api_key: @options[:api_key], app: @options[:app] }
      query_string = URI.encode_www_form params
      ws_url = "#{@uri}/events?#{query_string}"
      if @ws
        %w{ open message error close }.each { |e| @ws.remove_listener(e) }
        @ws.close
      end
      @ws = WebSocket::Client::Simple.connect ws_url
      @ws.on :open,    &method(:handle_websocket_open)
      @ws.on :message, &method(:handle_websocket_message)
      @ws.on :error,   &method(:handle_websocket_error)
      @ws.on :close,   &method(:handle_websocket_close)
    end

    private

    def handle_websocket_open
      self.emit :websocket_open
    end

    def handle_websocket_message(event)
      handle_websocket_close(event) and return if event.type == :close
      return unless event.type == :text

      object = MultiJson.load event.data

      handler_klass = Ari.const_get object['type'] rescue nil
      return unless handler_klass
      event_name = object['type'].gsub(/([a-z\d])([A-Z])/,'\1_\2').downcase

      instances = self.class.instance_listeners[event_name.to_sym]

      event_properties = (handler_klass.instance_methods - Ari::Event.instance_methods)
      event_properties.reject! { |p| p.to_s.end_with? '=' }
      handler = handler_klass.new(object.merge(client: self))
      event_model_ids = event_properties.map { |p| handler.send(p).id rescue nil }.compact
      [*instances].each do |instance|
        if event_model_ids.include? instance.id
          Thread.new { emit "#{event_name}-#{instance.id}", handler }
        end
      end

      Thread.new { self.emit event_name, handler_klass.new(object.merge(client: self)) }
    rescue => err
      emit :websocket_error, err
    end

    def handle_websocket_error(err)
      self.emit :websocket_error, err
    end

    def handle_websocket_close(event)
      self.emit :websocket_close, event
    end

    def send_request(request)
      http = Net::HTTP.new(@uri.host, @uri.port)
      http.open_timeout = @options[:open_timeout]
      http.read_timeout = @options[:read_timeout]
      http.use_ssl = @uri.scheme == 'https'
      response = http.request(request)
      response_parsed = parse_response(response)
      if response.kind_of? Net::HTTPClientError
        raise Ari::RequestError.new(response.code), (response_parsed['message'] || response_parsed['error'])
      elsif response.kind_of? Net::HTTPServerError
        raise Ari::ServerError.new(response.code), (response_parsed['message'] || response_parsed['error'])
      end
      response_parsed
    end

    def parse_response(response)
      body = response.body
      return true if !body || body.empty?
      json = response['Content-Type'] == 'application/json'
      if json
        MultiJson.load body
      else
        body
      end
    end

    def self.instance_listeners
      @instance_listeners ||= {}
      @instance_listeners
    end

  end
end
