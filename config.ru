require 'sinatra/base'
require './app/phogo'

# map the controllers to routes
map('/example') { run Phogo::Controllers::ExampleController }
map('/') { run Phogo::Controllers::ApplicationController }
