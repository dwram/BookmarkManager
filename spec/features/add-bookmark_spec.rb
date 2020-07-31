require_relative '../spec_helper'

feature '#add_bookmark' do

  context 'via homepage' do

    before '/' do
      homepage
    end

    scenario 'presence of add_bookmark' do
      expect(page).to have_button('Add Bookmark')
    end

  end

  context 'via bookmarks list' do

    before '/view_bookmarks' do
      view_bookmarks
    end

    scenario 'new bookmark field' do
      expect(page).to have_field('url')
    end

    scenario 'new bookmark added' do
      expect(page).to have_button('Add Bookmark')
      fill_in('title', with: 'Google')
      fill_in('url', with: 'https://www.google.com')
      click_button ''
      expect(page).to have_link('Google', href: 'https://www.google.com')
    end

  end
end
