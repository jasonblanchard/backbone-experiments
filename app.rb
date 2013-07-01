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

get '/app/todos' do
    todos = Todo.all.to_a
    todos.to_json
end

get '/app/todos/:id' do
    todo = Todo.find(params[:id])
    todo.to_json
end

post '/app/todos' do
    todo = JSON.parse(request.body.read.to_s)
    Todo.create(todo)
end

put '/app/todos/:id' do
    todo_params = JSON.parse(request.body.read.to_s)
    todo = Todo.find(params[:id])
    todo.update_attributes(todo_params)
end

delete '/app/todos/:id' do
    Todo.find(params[:id]).destroy
end
