require_relative './spec_helper'


def connection
  DatabaseConnection.setup(dbname: 'bookmark_manager_test')
end

def generate_example_bookmarks
  DatabaseConnection.query("INSERT INTO bookmarks (url, title) VALUES('https://www.facebook.com', 'facebook'),
   ('https://www.amazon.com', 'amazon'), ('https://www.myspace.com', 'myspace'), ('https://www.twitter.com', 'twitter'),
   ('https://www.twitch.tv', 'twitch'), ('https://www.reddit.com', 'reddit'), ('https://www.google.com', 'google')")
end

def add_bookmark(url, title)
  DatabaseConnection.query("INSERT INTO bookmarks (url, title) VALUES('#{url}','#{title}')")
end

def truncation
  return unless ENV['RACK_ENV'] == 'test'
  DatabaseConnection.query('TRUNCATE bookmarks')
  DatabaseConnection.query('ALTER SEQUENCE bookmarks_id_seq RESTART WITH 1')
end