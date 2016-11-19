require 'sinatra/base'
require './app/controllers'

use Rack::Static, urls: ["/static"], root: "public"

# map the controllers to routes
map('/') do
  run Phogo::Controllers::MainController
end
