require 'rspec'
require 'rack/test'
require './app/phogo'

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end
