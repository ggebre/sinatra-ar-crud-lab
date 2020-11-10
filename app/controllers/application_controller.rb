
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/articles' do
    @articles = Article.all
    erb :index
  end

  get '/articles/new' do 
    erb :new
  end

  get '/articles/:id' do 
    @article = Article.find_by(id: params[:id].to_i)
    erb :show
  end

  
  get '/articles/:id/edit' do 
    @article = Article.find(params[:id].to_i)
    erb :edit
  end

  patch '/articles/:id' do 
  
    article = Article.find_by(id: params[:id] )
    article.update(params[:article])
    
  
    redirect "/articles/#{article.id}"
  end

  post '/articles' do 
   
    article = Article.create(params[:article])
    redirect "/articles/#{article[:id]}"
    
  end

  delete '/articles/:id' do 
    Article.find_by(id: params[:id].to_i).destroy 
    redirect "/articles"
  end
end
