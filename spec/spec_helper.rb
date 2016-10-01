require 'rspec'
require 'rack/test'

# pull in the helpers and controllers
Dir.glob('./app/{helpers,controllers}/*.rb').each { |file| require file }

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end
