require_relative './spec_helper'
require_relative '../models/comment'

describe Comment do

  it '#add_comment (two)' do
    generate_example_bookmarks
    Comment.add(comment: 'bye felicia', bookmark_id: 3).map(&:itself)
    Comment.add(comment: 'bye felicia2', bookmark_id: 3).map(&:itself)
    expect(Comment.from_bookmark(bookmark_id: 3).first.text).to eq 'bye felicia'
    expect(Comment.from_bookmark(bookmark_id: 3).last.text).to eq 'bye felicia2'
  end

  it '#view_comment' do
    generate_example_bookmarks
    Comment.add(comment: 'bye felicia', bookmark_id: 3).map(&:itself)
    Comment.add(comment: 'bye felicia2', bookmark_id: 3).map(&:itself)
    expect(Comment.all).to be_an Array
  end

end
