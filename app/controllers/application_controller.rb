require_relative '../../config/environment'
require 'pry'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/posts/new' do
    erb :new
  end

  post '/posts' do
  	@posts = [Post.create(params)]
  	erb :index
  end


  get '/posts' do
  	@posts = Post.all
  	erb :index
  end

  get '/posts/:id' do
  	@posts = [Post.find_by(id: params[:id])]
  	erb :index
  end

  patch '/posts/:id' do
  	@post = Post.find_by(id: params[:id])
  	@post.update(name: params[:name], content: params[:content])
  	@posts = [@post]
  	erb :index
  end

  get '/posts/:id/edit' do
  	@post = Post.find_by(id: params[:id])
  	erb :edit
  end

  delete '/posts/:id/delete' do
  	@post = Post.find_by(id: params[:id])
  	rtn = "#{@post.name} was deleted"
  	@post.destroy
  	rtn
  end

  get '/clear' do
  	Post.destroy_all
  	"Cleared"
  end
end