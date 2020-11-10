
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

  get '/articles/:id' do 
    id = params[:id].to_i
    @article = Article.find(id)
    erb :show
  end

  get '/articles/new' do 
    erb :new
  end

  get '/articles/:id/edit' do 
    @article = Article.find(params[:id].to_i)
    erb :edit
  end

  patch '/articles/:id' do 
    puts params[:title]
    # find by id
    # update the retrieved article with the data
    article = Article.find_by(id: params[:id] )
    article.update(title: params[:title], content: params[:content])
    @article = Article.find_by(id: params[:id] )
    erb :show
  end

  post '/articles' do 
    title = params[:title]
    content = params[:content]
    new_article = Article.create(title: title, content: content)
    @articles = Article.all
    
    erb :index
  end

  delete '/articles/:id' do 
      article = Article.find_by(id: params[:id].to_i)
      article.destroy

      @articles = Article.all
      erb :index
  end
end
