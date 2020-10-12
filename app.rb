require 'sinatra/base'
require 'sinatra'
require 'sinatra/reloader'
require 'json'
require 'pry'
require 'rack/contrib/json_body_parser'
require 'dm-core'
require 'data_mapper' 
require 'dm-timestamps'
require 'dm-validations'


# Set up the helpers, models, routes and services
APP_ROOT = File.dirname(__FILE__)
Dir["#{APP_ROOT}/helpers/*.rb"].each { |file| require file }
Dir["#{APP_ROOT}/models/*.rb"].each { |file| require file }
Dir["#{APP_ROOT}/routes/*.rb"].each { |file| require file }
Dir["#{APP_ROOT}/services/*.rb"].each { |file| require file }
  


# Main App Class where database routes are registered and postgresql is configured.
# And application can be bootstrap if running application directly by executing
# app.rb file
class App < Sinatra::Base
  register Sinatra::Reloader

  use Rack::JSONBodyParser
  use UsersRoute


  configure :development do
    DataMapper.setup(:default, "postgres://#{ENV['DB_USER']}:#{ENV['DB_PASS']}@#{ENV['DB_HOST']}/#{ENV['DB_NAME']}")
  end

  configure :test do
    DataMapper.setup(:default, "postgres://#{ENV['DB_USER']}:#{ENV['DB_PASS']}@#{ENV['DB_HOST']}/#{ENV['TEST_DB_NAME']}")
  end

  DataMapper.finalize.auto_upgrade! 

end
