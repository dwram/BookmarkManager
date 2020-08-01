require 'sinatra'
require 'rack-flash'
require_relative './models/bookmark'
require_relative './models/comment'
require_relative './models/database_script'

class BookmarkManager < Sinatra::Base

  enable :sessions, :method_override
  use Rack::Flash


  get '/' do
    erb :index
  end

  get '/bookmarks' do
    @bookmarks = Bookmark.all
    erb :bookmarks
  end

  post '/bookmarks/new' do
    flash[:notice] = "Invalid URL" unless Bookmark.add(url: params[:url], title: params[:title])
    redirect '/bookmarks'
  end

  delete'/bookmarks/:id' do
    Bookmark.delete(params[:id])
    redirect to '/bookmarks'
  end

  patch '/bookmarks/:id' do
    Bookmark.update(id: params[:id],url: params[:update_url],title: params[:update_title])
    redirect to '/bookmarks'
  end

  post '/bookmarks/:id/comments/new' do
    Comment.add(comment: params[:comment_text], bookmark_id: params[:id])
    redirect to '/bookmarks'
  end

  post '/bookmarks/:id/tag/new' do
    tag_id = Tag.add(content: params[:tag_text]).id
    BookmarkTags.add(bookmark_id: params[:id], tag_id: tag_id)
    redirect '/bookmarks'
  end


end
