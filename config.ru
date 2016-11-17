require 'sinatra/base'
require './app/phogo'

# map the controllers to routes
map('/') { run Phogo::Controllers::MainController }
