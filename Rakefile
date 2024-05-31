require "bundler/gem_tasks"
require 'net/http'
require 'json'
require 'ari/generators/resource_generator'
require "rake/testtask"

task :default => :test

Rake::TestTask.new do |t|
  t.pattern = "test/**/*_test.rb"
end

desc "Generate resources from JSON specification"
task :generate do
  base_url = 'https://raw.githubusercontent.com/asterisk/asterisk/master/rest-api%{path}'
  spec_url = base_url % { path: "/resources.json" }
  spec = Net::HTTP.get URI.parse(spec_url)
  resources = JSON.parse(spec)["apis"]

  resource_options = {
    asterisk: {
      resource_klass_name: 'AsteriskInfo'
    },
    applications: {
      id_attribute_name: 'applicationName'
    },
    events: {
      only_models: true
    }
  }

  models_path = File.join(__dir__, 'lib', 'ari', 'models.rb')
  FileUtils.rm_f models_path
  models_file = File.new(models_path, 'a')

  resources_path = File.join(__dir__, 'lib', 'ari', 'resources.rb')
  FileUtils.rm_f resources_path
  resources_file = File.new(resources_path, 'a')

  resources.each do |resource|
    url = base_url % { path: resource["path"].gsub("{format}", "json") }
    resource_name = resource["path"].split(/[\/.]/)[-2]
    puts ">> generating #{resource_name} from #{url}"
    json = JSON.parse Net::HTTP.get(URI.parse(url))
    generator = Ari::Generators::ResourceGenerator.new(
      resource_name,
      json,
      resource_options[resource_name.to_sym] || {}
    )
    generator.generate

    resources_file.puts "require 'ari/resources/#{generator.resource_name}'"
    generator.models.each do |model|
      next if model.name == generator.resource_name
      models_file.puts "require 'ari/models/#{model.name}'"
    end
  end

  models_file.close
end
