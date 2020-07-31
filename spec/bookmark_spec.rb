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

    id = 7
    let(:update) { Bookmark.update(id: id, title: 'netflixer', url: 'https://www.netflixer.com') }
    let(:incomplete_update_params) { Bookmark.update(id: id, title: 'netflixer', url: 'www.netflixer.com')}

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
      deleted = Bookmark.delete(id).first
      expect{ Bookmark.delete(id) }.to change{Bookmark.all}
      expect(deleted['url']).to include 'google'
      expect(deleted['id']).to eq '7'
    end

    it '#update' do
      update
      expect(Bookmark.all.map(&:itself).last.title).to include 'netflixer'
      expect(Bookmark.all.map(&:itself).last.title).not_to be 'netflix'
      expect(update.first['title']).to eq 'netflixer'
    end

    it '#update url missing http' do
      incomplete_update_params
      expect(incomplete_update_params.first['url']).to eq 'http://www.netflixer.com'
    end

    it 'fail update tests' do
      expect(Bookmark.update(id: id, title: 'test543', url: 'test543')).to be_falsey
      expect(Bookmark.update(id: id, title: 'test543', url: 'http://test543')).to be_falsey
      expect(Bookmark.update(id: id, title: 'test543', url: 'http://')).to be_falsey
      expect(Bookmark.update(id: id, title: 'test543', url: 'http:')).to be_falsey
      expect(Bookmark.update(id: id, title: '', url: 'http://www.nothing.com')).to be_falsey
    end

  end

end
