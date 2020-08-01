require 'pg'
require 'uri'
require 'addressable/uri'
require_relative './database'
require_relative './comment'
require_relative './tag'

class Bookmark
  attr_reader :url, :title, :id

  SCHEMES = %w(http https)

  def initialize(id:, url:, title:)
    @id = id
    @url = url
    @title = title
  end


  def comments(comments = Comment)
    comments.from_bookmark(bookmark_id: @id)
  end

  def get_tags(tags = Tag)
    tags.from_bookmark(bookmark_id: @id)
  end

  def self.connection
    ENV['RACK_ENV'] == 'test' ?
        PG.connect(dbname: 'bookmark_manager_test', user: 'postgres', password: '') :
        PG.connect(dbname: 'bookmark_manager', user: 'postgres', password: '')
  end

  def self.add(url:, title:)
    return unless !title.empty? && valid_url?(url)

    DatabaseConnection.query("INSERT INTO bookmarks (url, title) VALUES('#{url}','#{title}') RETURNING id, url, title")
  end

  def self.filter_by_title(title)
    DatabaseConnection.query("SELECT title, url FROM bookmarks WHERE title = '#{title}' OR title = '#{title.downcase}'
    OR url LIKE '%#{title.downcase}%'")
  end

  def self.all
    DatabaseConnection.query('SELECT * FROM bookmarks').map{ |record| Bookmark.new(id: record['id'], url: record['url'], title: record['title']) }
  end

  def self.delete(id)
    DatabaseConnection.query("DELETE FROM bookmarks WHERE id = '#{id}' RETURNING id, url, title")
  end

  def self.update(id:, url:, title:)
    return unless !title.empty? && valid_url?(url)

    DatabaseConnection.query("UPDATE bookmarks SET url='#{url}', title='#{title}' WHERE id='#{id}' RETURNING id, url, title")
  end

  private

  def self.valid_url?(url)
    url.insert(0, 'http://') unless url.include?('http://') || url.include?('https://')
    url_regexp = /^(((http|https):\/\/|)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,6}(:[0-9]{1,5})?(\/.*)?)$/ix
    url =~ url_regexp ? true : false
  end

end
