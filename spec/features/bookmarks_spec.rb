require_relative '../spec_helper'


feature 'viewing bookmarks' do

  scenario 'views bookmarks' do
    view_bookmarks
    expect(page.status_code).to_not eq(404)
    expect(page).to have_content(/bookmarks/i)
  end

end