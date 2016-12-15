require 'sendgrid-ruby'
require 'ostruct'
require 'sinatra/param'

module Phogo
  module Controllers
    class MainController < ApplicationController
      helpers Sinatra::Param

      get '/' do
        erb :index, :layout => :'layout/_main'
      end

      get '/thankyou' do
        erb :thank_you, :layout => :'layout/_main'
      end

      post '/contact' do
        param :name, String, required: true
        param :email, String, required: true, format: /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
        param :message, String, required: true
        param :subject, String, default: 'Contact request'

        @contact = OpenStruct.new(params)
        content_body = erb :'templates/email'

        from = SendGrid::Email.new(name: @contact.name, email: @contact.email)
        to = SendGrid::Email.new(email: ENV.fetch('PHOGO_EMAIL_RECIPIENT'))
        content = SendGrid::Content.new(type: 'text/html', value: content_body)
        mail = SendGrid::Mail.new(from, @contact.subject, to, content)
        sendgrid = SendGrid::API.new(api_key: ENV.fetch('SENDGRID_API_KEY'))
        sendgrid.client.mail._('send').post(request_body: mail.to_json)

        redirect '/thankyou'
      end
    end
  end
end
