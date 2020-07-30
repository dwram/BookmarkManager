require 'sinatra'
require_relative './models/bookmark'

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
    p params[:id]
  end


end
