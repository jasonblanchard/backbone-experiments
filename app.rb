require 'sinatra'
require 'mongoid'
require 'json'

Mongoid.load!("config/mongoid.yml")

enable :sessions

class Todo
    include Mongoid::Document
    include Mongoid::Timestamps

    field :title
    field :completed, :type => Boolean, :default => false
end

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

get '/app' do
    @todos = Todo.all.to_a
    erb :app
end

post '/app/todo' do
    todo = JSON.parse(request.body.read.to_s)
    Todo.create(todo)
end
