require 'pg'

class Bookmark
  attr_reader :url, :title, :id

  def initialize(id:, url:, title:)
    @id = id
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

  def self.filter_by_title(title)
    connection.exec("SELECT title, url FROM bookmarks WHERE title = '#{title}' OR title = '#{title.downcase}'
    OR url LIKE '%#{title.downcase}%'")
  end

  def self.all
    connection.exec('SELECT * FROM bookmarks').map{ |record| Bookmark.new(id: record['id'], url: record['url'], title: record['title']) }
  end

end
