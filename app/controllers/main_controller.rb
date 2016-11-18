module Phogo
  module Controllers
    class MainController < ApplicationController
      get '/' do
        erb :index, :layout => :'layout/_main'
      end

      get '/approach' do
        erb :approach, :layout => :'layout/_main'
      end

      get '/services' do
        erb :services, :layout => :'layout/_main'
      end

      get '/about' do
        erb :about, :layout => :'layout/_main'
      end
    end
  end
end