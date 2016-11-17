require 'spec_helper'

describe 'MainController' do
  let(:app) { Phogo::Controllers::MainController.new }

  describe 'GET /' do
    it 'display the default message' do
      get '/'
      expect(last_response.body).to include("Phogo Labs")
    end
  end
end
