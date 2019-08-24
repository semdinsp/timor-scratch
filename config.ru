require 'rubygems'
require 'bundler/setup'
require 'rack/ssl'

Bundler.require(:default)
use Rack::Deflater

use Rack::ConditionalGet
use Rack::ETag
require 'nesta/env'
puts "Envionment is: #{ENV['RACK_ENV']}"
if ENV['RACKAPP_ENV']=='production'
  use Rack::SSL 
  puts "force ssl with rack-ssl"
end 


Nesta::Env.root = ::File.expand_path('.', ::File.dirname(__FILE__))

require 'nesta/app'
run Nesta::App
