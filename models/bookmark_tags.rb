require_relative './database_script'

class BookmarkTags

  def self.add(bookmark_id:, tag_id:)
    DatabaseConnection.query("INSERT INTO bookmark_tags (bookmark_id, tag_id) VALUES('#{bookmark_id}','#{tag_id}') RETURNING *")
  end


end
