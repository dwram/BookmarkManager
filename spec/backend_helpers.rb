require_relative './spec_helper'

def database
  PG.connect(dbname: 'bookmark_manager_test', user: 'postgres', password: '')
end

def generate_example_bookmarks
  database.query("INSERT INTO bookmarks (url, title) VALUES('https://www.facebook.com', 'facebook'),
   ('https://www.amazon.com', 'amazon'), ('https://www.myspace.com', 'myspace'), ('https://www.twitter.com', 'twitter'),
   ('https://www.twitch.tv', 'twitch'), ('https://www.reddit.com', 'reddit'), ('https://www.google.com', 'google')")
end

def generate_example_tags
  database.query("INSERT INTO tags (content) VALUES('Great'),('Terrible!'),('Amazing front-end!')")
end

def add_bookmark(url, title)
  database.query("INSERT INTO bookmarks (url, title) VALUES('#{url}','#{title}')")
end

def truncation
  return unless ENV['RACK_ENV'] == 'test'

  database.query('TRUNCATE bookmark_tags, tags, bookmarks, comments RESTART IDENTITY')
  #database.query('ALTER SEQUENCE bookmarks_id_seq RESTART WITH 1')
  #database.query('ALTER SEQUENCE comments_id_seq RESTART WITH 1')
end