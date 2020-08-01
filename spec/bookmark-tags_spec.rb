require_relative './spec_helper'
require_relative '../models/bookmark_tags'

describe BookmarkTags do

  it 'new bookmark tag' do
    generate_example_bookmarks
    generate_example_tags
    bookmark_id = 1; tag_id = 1
    new_tag = BookmarkTags.add(bookmark_id: bookmark_id, tag_id: tag_id).first
    expect(new_tag['id']).to eq '1'
  end

end