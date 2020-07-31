require 'sinatra'
require_relative './models/bookmark'
require_relative './models/database_script'

class BookmarkManager < Sinatra::Base

  enable :sessions, :method_override

  get '/' do
    erb :index
  end

  get '/bookmarks' do
    @bookmarks = Bookmark.all
    erb :bookmarks
  end

  post '/bookmarks/new' do
    Bookmark.add(url: params[:url], title: params[:title])
    redirect '/bookmarks'
  end

  delete'/bookmarks/:id' do
    Bookmark.delete(params[:id])
    redirect to '/bookmarks'
  end

  put '/bookmarks/:id' do
    Bookmark.update(id: params[:id],url: params[:update_url],title: params[:update_title])
    redirect to '/bookmarks'
  end


end
