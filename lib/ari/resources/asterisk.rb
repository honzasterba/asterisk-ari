#------------------------------------------------------------------------------
#
#  WARNING !
#
#  This is a generated file. DO NOT EDIT THIS FILE! Your changes will
#  be lost the next time this file is regenerated.
#
#  This file was generated using asterisk-ari-client ruby gem.
#
#------------------------------------------------------------------------------

module Ari
  class Asterisk < Resource


    # GET /asterisk/config/dynamic/%{configClass}/%{objectType}/%{id}
    #
    # Asterisk dynamic configuration
    #
    #
    # Parameters:
    #
    # configClass (required) - The configuration class containing dynamic configuration objects.
    # objectType (required) - The type of configuration object to retrieve.
    # id (required) - The unique identifier of the object to retrieve.
    #
    def self.get_object(options = {})
      raise ArgumentError.new("Parameter configClass must be passed in options hash.") unless options[:configClass]
      raise ArgumentError.new("Parameter objectType must be passed in options hash.") unless options[:objectType]
      raise ArgumentError.new("Parameter id must be passed in options hash.") unless options[:id]
      path = '/asterisk/config/dynamic/%{configClass}/%{objectType}/%{id}' % options
      response = client(options).get(path, options)
      response.map { |hash| ConfigTuple.new(hash.merge(client: options[:client])) }
    end
    class << self; alias_method :getObject, :get_object; end

    def get_object(options = {})
      self.class.get_object(options.merge(asteriskId: self.id, client: @client))
    end

    # PUT /asterisk/config/dynamic/%{configClass}/%{objectType}/%{id}
    #
    # Asterisk dynamic configuration
    #
    #
    # Parameters:
    #
    # configClass (required) - The configuration class containing dynamic configuration objects.
    # objectType (required) - The type of configuration object to create or update.
    # id (required) - The unique identifier of the object to create or update.
    # fields  - The body object should have a value that is a list of ConfigTuples, which provide the fields to update. Ex. [ { "attribute": "directmedia", "value": "false" } ]
    #
    def self.update_object(options = {})
      raise ArgumentError.new("Parameter configClass must be passed in options hash.") unless options[:configClass]
      raise ArgumentError.new("Parameter objectType must be passed in options hash.") unless options[:objectType]
      raise ArgumentError.new("Parameter id must be passed in options hash.") unless options[:id]
      path = '/asterisk/config/dynamic/%{configClass}/%{objectType}/%{id}' % options
      response = client(options).put(path, options)
      response.map { |hash| ConfigTuple.new(hash.merge(client: options[:client])) }
    end
    class << self; alias_method :updateObject, :update_object; end

    def update_object(options = {})
      self.class.update_object(options.merge(asteriskId: self.id, client: @client))
    end

    # DELETE /asterisk/config/dynamic/%{configClass}/%{objectType}/%{id}
    #
    # Asterisk dynamic configuration
    #
    #
    # Parameters:
    #
    # configClass (required) - The configuration class containing dynamic configuration objects.
    # objectType (required) - The type of configuration object to delete.
    # id (required) - The unique identifier of the object to delete.
    #
    def self.delete_object(options = {})
      raise ArgumentError.new("Parameter configClass must be passed in options hash.") unless options[:configClass]
      raise ArgumentError.new("Parameter objectType must be passed in options hash.") unless options[:objectType]
      raise ArgumentError.new("Parameter id must be passed in options hash.") unless options[:id]
      path = '/asterisk/config/dynamic/%{configClass}/%{objectType}/%{id}' % options
      client(options).delete(path, options)
    rescue Ari::RequestError => e
      raise unless e.code == '404'
    end
    class << self; alias_method :deleteObject, :delete_object; end

    def delete_object(options = {})
      self.class.delete_object(options.merge(asteriskId: self.id, client: @client))
    end

    # GET /asterisk/info
    #
    # Asterisk system information (similar to core show settings)
    #
    #
    # Parameters:
    #
    # only  - Filter information returned
    #
    def self.get_info(options = {})
      path = '/asterisk/info'
      response = client(options).get(path, options)
      AsteriskInfo.new(response.merge(client: options[:client]))
    end
    class << self; alias_method :getInfo, :get_info; end

    # GET /asterisk/ping
    #
    # Asterisk ping
    #
    #
    def self.ping(options = {})
      path = '/asterisk/ping'
      response = client(options).get(path, options)
      AsteriskPing.new(response.merge(client: options[:client]))
    end

    # GET /asterisk/modules
    #
    # Asterisk modules
    #
    #
    def self.list_modules(options = {})
      path = '/asterisk/modules'
      response = client(options).get(path, options)
      response.map { |hash| Module.new(hash.merge(client: options[:client])) }
    end
    class << self; alias_method :listModules, :list_modules; end

    # GET /asterisk/modules/%{moduleName}
    #
    # Asterisk module
    #
    #
    # Parameters:
    #
    # moduleName (required) - Module's name
    #
    def self.get_module(options = {})
      raise ArgumentError.new("Parameter moduleName must be passed in options hash.") unless options[:moduleName]
      path = '/asterisk/modules/%{moduleName}' % options
      response = client(options).get(path, options)
      Module.new(response.merge(client: options[:client]))
    end
    class << self; alias_method :getModule, :get_module; end

    def get_module(options = {})
      self.class.get_module(options.merge(asteriskId: self.id, client: @client))
    end

    # POST /asterisk/modules/%{moduleName}
    #
    # Asterisk module
    #
    #
    # Parameters:
    #
    # moduleName (required) - Module's name
    #
    def self.load_module(options = {})
      raise ArgumentError.new("Parameter moduleName must be passed in options hash.") unless options[:moduleName]
      path = '/asterisk/modules/%{moduleName}' % options
      client(options).post(path, options)
    end
    class << self; alias_method :loadModule, :load_module; end

    def load_module(options = {})
      self.class.load_module(options.merge(asteriskId: self.id, client: @client))
    end

    # DELETE /asterisk/modules/%{moduleName}
    #
    # Asterisk module
    #
    #
    # Parameters:
    #
    # moduleName (required) - Module's name
    #
    def self.unload_module(options = {})
      raise ArgumentError.new("Parameter moduleName must be passed in options hash.") unless options[:moduleName]
      path = '/asterisk/modules/%{moduleName}' % options
      client(options).delete(path, options)
    rescue Ari::RequestError => e
      raise unless e.code == '404'
    end
    class << self; alias_method :unloadModule, :unload_module; end

    def unload_module(options = {})
      self.class.unload_module(options.merge(asteriskId: self.id, client: @client))
    end

    # PUT /asterisk/modules/%{moduleName}
    #
    # Asterisk module
    #
    #
    # Parameters:
    #
    # moduleName (required) - Module's name
    #
    def self.reload_module(options = {})
      raise ArgumentError.new("Parameter moduleName must be passed in options hash.") unless options[:moduleName]
      path = '/asterisk/modules/%{moduleName}' % options
      client(options).put(path, options)
    end
    class << self; alias_method :reloadModule, :reload_module; end

    def reload_module(options = {})
      self.class.reload_module(options.merge(asteriskId: self.id, client: @client))
    end

    # GET /asterisk/logging
    #
    # Asterisk log channels
    #
    #
    def self.list_log_channels(options = {})
      path = '/asterisk/logging'
      response = client(options).get(path, options)
      response.map { |hash| LogChannel.new(hash.merge(client: options[:client])) }
    end
    class << self; alias_method :listLogChannels, :list_log_channels; end

    # POST /asterisk/logging/%{logChannelName}
    #
    # Asterisk log channel
    #
    #
    # Parameters:
    #
    # logChannelName (required) - The log channel to add
    # configuration (required) - levels of the log channel
    #
    def self.add_log(options = {})
      raise ArgumentError.new("Parameter logChannelName must be passed in options hash.") unless options[:logChannelName]
      raise ArgumentError.new("Parameter configuration must be passed in options hash.") unless options[:configuration]
      path = '/asterisk/logging/%{logChannelName}' % options
      client(options).post(path, options)
    end
    class << self; alias_method :addLog, :add_log; end

    def add_log(options = {})
      self.class.add_log(options.merge(asteriskId: self.id, client: @client))
    end

    # DELETE /asterisk/logging/%{logChannelName}
    #
    # Asterisk log channel
    #
    #
    # Parameters:
    #
    # logChannelName (required) - Log channels name
    #
    def self.delete_log(options = {})
      raise ArgumentError.new("Parameter logChannelName must be passed in options hash.") unless options[:logChannelName]
      path = '/asterisk/logging/%{logChannelName}' % options
      client(options).delete(path, options)
    rescue Ari::RequestError => e
      raise unless e.code == '404'
    end
    class << self; alias_method :deleteLog, :delete_log; end

    def delete_log(options = {})
      self.class.delete_log(options.merge(asteriskId: self.id, client: @client))
    end

    # PUT /asterisk/logging/%{logChannelName}/rotate
    #
    # Asterisk log channel
    #
    #
    # Parameters:
    #
    # logChannelName (required) - Log channel's name
    #
    def self.rotate_log(options = {})
      raise ArgumentError.new("Parameter logChannelName must be passed in options hash.") unless options[:logChannelName]
      path = '/asterisk/logging/%{logChannelName}/rotate' % options
      client(options).put(path, options)
    end
    class << self; alias_method :rotateLog, :rotate_log; end

    def rotate_log(options = {})
      self.class.rotate_log(options.merge(asteriskId: self.id, client: @client))
    end

    # GET /asterisk/variable
    #
    # Global variables
    #
    #
    # Parameters:
    #
    # variable (required) - The variable to get
    #
    def self.get_global_var(options = {})
      raise ArgumentError.new("Parameter variable must be passed in options hash.") unless options[:variable]
      path = '/asterisk/variable'
      response = client(options).get(path, options)
      Variable.new(response.merge(client: options[:client]))
    end
    class << self; alias_method :getGlobalVar, :get_global_var; end

    # POST /asterisk/variable
    #
    # Global variables
    #
    #
    # Parameters:
    #
    # variable (required) - The variable to set
    # value  - The value to set the variable to
    #
    def self.set_global_var(options = {})
      raise ArgumentError.new("Parameter variable must be passed in options hash.") unless options[:variable]
      path = '/asterisk/variable'
      client(options).post(path, options)
    end
    class << self; alias_method :setGlobalVar, :set_global_var; end

  end
end

Ari::Client.send :define_method, 'asterisk' do
  Ari::ListResource.new(self, Ari::Asterisk)
end
