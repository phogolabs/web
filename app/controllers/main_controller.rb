module Phogo
  module Controllers
    class MainController < ApplicationController
      get '/' do
        erb :index, :layout => :'layout/_main'
      end
    end
  end
end
