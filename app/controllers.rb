require 'sinatra'
require "sinatra/base"
require 'sinatra/reloader'
require "rack/csrf"
require 'securerandom'
require './app/helpers'
require 'rack-google-analytics'

module Phogo
  module Controllers
    class ApplicationController < Sinatra::Base
      # include ApplicationHelper in views
      helpers Phogo::Helpers

      # set application root
      set :root, File.expand_path('../', __FILE__)
      # set folder for templates to ../views, but make the path absolute
      set :views, File.expand_path('../views', __FILE__)

      configure :development do
        # Prevent CSRF attacks by raising an exception.
        use Rack::Session::Cookie, :secret => SecureRandom.hex
        # enable hot reloader
        register Sinatra::Reloader
        # don't enable logging when running tests
        disable :logging

        if ENV['BASIC_AUTH_USER'] && ENV['BASIC_AUTH_PASS']
          use Rack::Auth::Basic, "Protected Area" do |username, password|
            username == ENV['BASIC_AUTH_USER'] && password == ENV['BASIC_AUTH_PASS']
          end
        end

      end

      # configuration in production
      configure :production do
        # enable static files caching
        set :static_cache_control, [:public, max_age: 60]
        # show exceptions after handlers
        set :show_exceptions, :after_handler
        # Prevent CSRF attacks by raising an exception.
        use Rack::Session::Cookie, :secret => ENV.fetch('COOKIE_SECRET')
        # Enable Google Analytics
        use Rack::GoogleAnalytics, :tracker => ENV.fetch('GOOGLE_TRACKING_ID')
        # For APIs, you may want to use :null_session instead.
        use Rack::Csrf, :raise => true
        # enable logging when running tests
        enable :logging
      end

    end
  end
end

Dir[File.join(File.dirname(__FILE__), 'controllers', '*.rb')].each do |filename|
  require filename
end
