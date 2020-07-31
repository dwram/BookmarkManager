require_relative '../spec_helper'

feature '#update_bookmark' do
  before 'generate to delete' do
    generate_example_bookmarks
    view_bookmarks
  end

  scenario 'presence of deletion button' do
    expect(page).to have_link('google', href: 'https://www.google.com')
    expect(page).to have_button 'Update'
  end

  scenario 'update an entry' do
    fill_in 'update_title', with: 'facebooker', match: :first
    fill_in 'update_url', with: 'https://www.facebooker.com', match: :first
    click_button('Update', match: :first)
    expect(page).to have_content 'https://www.facebooker.com'
  end

end

