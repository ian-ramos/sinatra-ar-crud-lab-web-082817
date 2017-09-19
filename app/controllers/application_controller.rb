require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do

  end

  get '/posts/new' do
    erb :new
  end

  get '/posts' do
    @posts = Post.all
    erb :index
  end

  get '/posts/:id' do
    @found_post = Post.find(params[:id])
    erb :show
  end

  post '/posts' do
    Post.create(name: params[:name], content: params[:content])
    erb :index
  end

  get '/posts/:id/edit' do
    @found_post = Post.find(params[:id])
    erb :edit
  end

  patch '/posts/:id' do
    @updated_name = params[:name]
    @updated_content = params[:content]
    @found_post = Post.find(params[:id])
    @found_post.update(name: @updated_name, content: @updated_content)
    redirect to "/posts/#{@found_post.id}"
  end

  delete '/posts/:id/delete' do
    @post = Post.find_by_id(params[:id])
    @post.delete
    erb :delete
  end

end
