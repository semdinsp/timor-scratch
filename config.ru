require 'rubygems'
require 'bundler/setup'
require 'rack/ssl'

Bundler.require(:default)
use Rack::Deflater

use Rack::ConditionalGet
use Rack::ETag
require 'nesta/env'
puts "Envionment is: #{ENV['APP_ENV']}"
use Rack::SSL if ENV['APP_ENV']=='production' 


Nesta::Env.root = ::File.expand_path('.', ::File.dirname(__FILE__))

require 'nesta/app'
run Nesta::App
