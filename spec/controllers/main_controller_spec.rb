require 'spec_helper'
require 'sendgrid-ruby'
require 'erb'

describe 'MainController' do
  let(:app) { Phogo::Controllers::MainController.new }

  describe 'GET /' do
    it 'display the default message' do
      get '/'
      expect(last_response.body).to include("Phogo Labs")
    end
  end

  describe 'POST /contact' do
    let(:sendgrid) { double('sendgrid_client') }
    let(:client_sender) { double('sendgrid_client_sender') }
    let(:from_email) { double('from_email') }
    let(:to_email) { double('to_email') }
    let(:content) { double('content') }
    let(:mail) { double('mail') }

    before(:each) do
      ENV['PHOGO_EMAIL_RECIPIENT'] = 'no-spam@example.com'
      ENV['SENDGRID_API_KEY'] = 'SENDGRID_TEST_API_KEY'
    end

    it 'sends an email' do
      expect(SendGrid::Email).to receive(:new).with(hash_including(:name => 'John Dow', :email => 'from@example.com')).and_return(from_email)
      expect(SendGrid::Email).to receive(:new).with(hash_including(:email => ENV['PHOGO_EMAIL_RECIPIENT'])).and_return(to_email)
      expect(SendGrid::Content).to receive(:new).with(hash_including(:type => 'text/html')).and_return(content)
      expect(SendGrid::Mail).to receive(:new).with(from_email, 'Project Request', to_email, content).and_return(mail)
      expect(mail).to receive(:to_json).and_return('mail_json')

      expect(SendGrid::API).to receive(:new).with(hash_including(:api_key => ENV['SENDGRID_API_KEY'])).and_return(sendgrid)
      expect(sendgrid).to receive_message_chain(:client, :mail, :_).with('send').and_return(client_sender)
      expect(client_sender).to receive(:post).with(hash_including(:request_body => 'mail_json')).and_return(instance_double('response', :status_code => '202', :body => ''))

      post '/contact',
        :email =>'from@example.com',
        :name => 'John Dow',
        :subject => 'Project Request',
        :message => 'Hello World'

      expect(last_response.status).to eq(302)
    end

    context 'when the email send fails' do
      it 'sends an email' do
        expect(SendGrid::Email).to receive(:new).with(hash_including(:name => 'John Dow', :email => 'from@example.com')).and_return(from_email)
        expect(SendGrid::Email).to receive(:new).with(hash_including(:email => ENV['PHOGO_EMAIL_RECIPIENT'])).and_return(to_email)
        expect(SendGrid::Content).to receive(:new).with(hash_including(:type => 'text/html')).and_return(content)
        expect(SendGrid::Mail).to receive(:new).with(from_email, 'Project Request', to_email, content).and_return(mail)
        expect(mail).to receive(:to_json).and_return('mail_json')

        expect(SendGrid::API).to receive(:new).with(hash_including(:api_key => ENV['SENDGRID_API_KEY'])).and_return(sendgrid)
        expect(sendgrid).to receive_message_chain(:client, :mail, :_).with('send').and_return(client_sender)
        expect(client_sender).to receive(:post).with(hash_including(:request_body => 'mail_json')).and_return(instance_double('response', :status_code => '500', :body => 'oh no'))

        post '/contact',
          :email =>'from@example.com',
          :name => 'John Dow',
          :subject => 'Project Request',
          :message => 'Hello World'

        expect(last_response.status).to eq(500)
        expect(last_response.body).to eq('oh no')
      end
    end

    context 'when name is missing' do
      it 'returns an error' do
        expect(SendGrid::Email).not_to receive(:new)
        expect(SendGrid::Email).not_to receive(:new)
        expect(SendGrid::Content).not_to receive(:new)
        expect(SendGrid::Mail).not_to receive(:new)
        expect(SendGrid::API).not_to receive(:new)

        post '/contact',
          :email =>'from@example.com',
          :subject => 'Project Request',
          :message => 'Hello World'

        expect(last_response.status).to eq(400)
        expect(last_response.body).to eq('Parameter is required')
      end
    end

    context 'when email is missing' do
      it 'returns an error' do
        expect(SendGrid::Email).not_to receive(:new)
        expect(SendGrid::Email).not_to receive(:new)
        expect(SendGrid::Content).not_to receive(:new)
        expect(SendGrid::Mail).not_to receive(:new)
        expect(SendGrid::API).not_to receive(:new)

        post '/contact',
          :name => 'John Dow',
          :subject => 'Project Request',
          :message => 'Hello World'

        expect(last_response.status).to eq(400)
        expect(last_response.body).to eq('Parameter is required')
      end
    end

    context 'when email field has invalid value' do
      it 'returns an error' do
        expect(SendGrid::Email).not_to receive(:new)
        expect(SendGrid::Email).not_to receive(:new)
        expect(SendGrid::Content).not_to receive(:new)
        expect(SendGrid::Mail).not_to receive(:new)
        expect(SendGrid::API).not_to receive(:new)

        post '/contact',
          :name => 'John Dow',
          :email =>'from-example-com',
          :subject => 'Project Request',
          :message => 'Hello World'

        expect(last_response.status).to eq(400)
        expect(last_response.body).to include('Parameter must match format')
      end

    end

    context 'when message is missing' do
      it 'returns an error' do
        expect(SendGrid::Email).not_to receive(:new)
        expect(SendGrid::Email).not_to receive(:new)
        expect(SendGrid::Content).not_to receive(:new)
        expect(SendGrid::Mail).not_to receive(:new)
        expect(SendGrid::API).not_to receive(:new)

        post '/contact',
          :name => 'John Dow',
          :email =>'from@example.com',
          :subject => 'Project Request'

        expect(last_response.status).to eq(400)
        expect(last_response.body).to eq('Parameter is required')
      end
    end

  end
end
