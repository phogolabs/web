require 'sendgrid-ruby'
require 'ostruct'
require 'sinatra/param'

module Phogo
  module Controllers
    class MainController < ApplicationController
      helpers Sinatra::Param

      error 500 do
        erb :error, :layout => :'layout/_main', :locals => { :message => env['sinatra.error'].message }
      end

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
        param :subject, String

        @contact = OpenStruct.new(params)
        @contact.subject = "Contact Request by #{params[:name]}" if @contact.subject.nil? or @contact.subject.empty?
        content_body = erb :'templates/email'

        from = SendGrid::Email.new(name: @contact.name, email: @contact.email)
        to = SendGrid::Email.new(email: ENV.fetch('PHOGO_EMAIL_RECIPIENT'))
        content = SendGrid::Content.new(type: 'text/html', value: content_body)
        mail = SendGrid::Mail.new(from, @contact.subject, to, content)
        sendgrid = SendGrid::API.new(api_key: ENV.fetch('SENDGRID_API_KEY'))
        response = sendgrid.client.mail._('send').post(request_body: mail.to_json)

        raise StandardError, response.body if response.status_code != '202'
        redirect '/thankyou'
      end
    end
  end
end
