def homepage
  visit('/')
end

def view_bookmarks
  visit('/')
  click_button('Bookmarks')
end

def submit_bookmark
  click_button('Add Bookmark')
end

def remove_bookmark(url:, title:)
  fill_in 'remove_title', with: title.to_s
  fill_in 'remove_url', with: url.to_s
  click_button('Remove Bookmark')
end