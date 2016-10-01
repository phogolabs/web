require 'spec_helper'

describe 'ExampleController' do
  let(:app) { ExampleController.new }

  describe 'GET /' do
    it 'display the default message' do
      get '/'
      expect(last_response.body).to include("Example!")
    end
  end
end
