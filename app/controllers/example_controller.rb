class ExampleController < ApplicationController
  get '/' do
    'Example!'
  end

  get '/index' do
    @current_user = "Frank Sinatra"
    erb :example
  end
end
