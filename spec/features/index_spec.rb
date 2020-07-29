require_relative '../spec_helper'

feature 'Index' do

  before 'visit homepage' do
    visit('/')
  end

  scenario '#homepage' do
    expect(page).to have_content /bookmark manager/i
  end

  scenario 'presence of bookmarks buttom' do
    expect(page).to have_button('Bookmarks')
  end

  scenario 'presence of add_bookmark' do
    expect(page).to have_button('Add Bookmark')
  end

  scenario 'new bookmark fields' do
    expect(page).to have_field('url')
    expect(page).to have_field('title')
  end

end
