require 'sinatra'
require_relative './models/bookmark'

class BookmarkManager < Sinatra::Base

  get '/' do
    erb :index
  end

  get '/bookmarks' do
    @bookmarks = Bookmark.all
    erb :bookmarks
  end

  post '/add-bookmark' do
    Bookmark.add(url: params[:url], title: params[:title])
    redirect '/bookmarks'
  end

end
