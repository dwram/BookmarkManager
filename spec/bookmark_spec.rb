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

    it 'another add' do
      title = 'netflix'; url = 'https://www.netflix.com'
      expect { Bookmark.add(title: title, url: url) }.to change{ Bookmark.all.size }.by(1)
    end
  end

  context 'pre-populated DB' do

    before 'pre-poulate' do
      generate_example_bookmarks
    end

    it 'web helper generation' do
      expect(Bookmark.all.map(&:itself).last.title).to include 'google'
    end

    it 'filters entry' do
      #TODO: FILTER ENTRY SPEC
    end

    it '#delete' do
      id = 7
      deleted = Bookmark.delete(id).first
      expect{ Bookmark.delete(id) }.to change{Bookmark.all}
      expect(deleted['url']).to include 'google'
      expect(deleted['id']).to eq '7'
    end

  end

end
