require 'sinatra'
require 'mongoid'

Mongoid.load!("config/mongoid.yml")

enable :sessions

get '/hi' do
   @text ="hello, world"
   erb :hello
end

get '/services' do
    erb :services
end

get '/' do
    erb :index
end

get '/todo' do
    erb :todo
end
