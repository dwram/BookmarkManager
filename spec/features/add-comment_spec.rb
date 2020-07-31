require_relative '../spec_helper'

feature '#add_comment' do

  before 'pre-populate' do
    generate_example_bookmarks
    view_bookmarks
  end

  scenario 'presence of comment button' do
    expect(page).to have_button('Add comment')
  end

  scenario 'add a comment' do
    fill_in 'comment_text', with: 'test_comment'
  end

end