require_relative './spec_helper'


def connection
  PG.connect(dbname: 'bookmark_manager_test', user: 'postgres', password: '')
end

def generate_example_bookmarks
  connection.exec("INSERT INTO bookmarks (url, title) VALUES('https://www.facebook.com', 'facebook'),
   ('https://www.amazon.com', 'amazon'), ('https://www.myspace.com', 'myspace'), ('https://www.twitter.com', 'twitter'),
   ('https://www.twitch.tv', 'twitch'), ('https://www.reddit.com', 'reddit'), ('https://www.google.com', 'google')")
end

def add_bookmark(url, title)
  connection.exec("INSERT INTO bookmarks (url, title) VALUES('#{url}','#{title}')")
end

def truncation
  return unless ENV['RACK_ENV'] == 'test'
  connection.exec('TRUNCATE bookmarks')
  connection.exec('ALTER SEQUENCE bookmarks_id_seq RESTART WITH 1')
end
