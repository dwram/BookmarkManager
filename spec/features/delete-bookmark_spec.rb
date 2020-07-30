require_relative '../spec_helper'

feature '#delete_bookmark' do
  before 'generate to delete' do
    generate_example_bookmarks
    view_bookmarks
  end

  scenario 'presence of deletion button' do
    expect(page).to have_link('google', href: 'https://www.google.com')
    expect(page).to have_button 'Delete'
  end

  scenario 'delete an entry' do
    click_button 'Delete', :match => :first
    expect(page).not_to have_content 'facebook'
  end

end
