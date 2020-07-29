require_relative './spec_helper'
require_relative '../models/bookmark'

describe Bookmark do

  url = 'https://www.google.com'; title = 'google'

  context 'empty bookmarks' do

    it '#all' do
      expect(Bookmark.all).to be_an Array
      Bookmark.add(title: title, url: url)
      expect(Bookmark.all.first).to be_an_instance_of Bookmark
    end

    it '#add a bookmark google.com' do
      Bookmark.add(title: title, url: url)
      expect(Bookmark.all.map(&:itself).first.url).to include('https://www.google.com')
      expect(Bookmark.all.map(&:itself).first.title).to include('google')
    end

  end

  context 'pre-populated DB'

    it 'web helper generation' do
      generate_example_bookmarks
      expect(Bookmark.all.map(&:itself).last.title).to include 'reddit'
    end

end
