require 'rspec'
require 'rack/test'
require_relative '../app/controllers.rb'

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end
