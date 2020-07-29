require 'pg'

class Bookmark
  attr_reader :url, :title

  def initialize(url:,title:)
    @url = url
    @title = title
  end

  def self.connection
    ENV['RACK_ENV'] == 'test' ?
        PG.connect(dbname: 'bookmark_manager_test', user: 'postgres', password: '') :
        PG.connect(dbname: 'bookmark_manager', user: 'postgres', password: '')
  end

  def self.add(url:, title:)
    return unless url && title && url != /Enter bookmark here/i && title != /Enter title here/i

    connection.exec("INSERT INTO bookmarks (url, title) VALUES('#{url}','#{title}')")
  end

  def self.all
    connection.exec('SELECT * FROM bookmarks').map{ |record| Bookmark.new(url: record['url'], title: record['title']) }
  end

end