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