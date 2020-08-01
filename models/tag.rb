require_relative './database_script'

class Tag
  attr_reader :content, :id

  def initialize(content:, id:)
    @id = id
    @content = content
  end

  def self.add(content:)
    DatabaseConnection.query("INSERT INTO tags (content) VALUES('#{content}') RETURNING *")
        .map{ |record| return Tag.new(content: record['content'], id: record['id']) } # beware of return
  end

  def self.from_bookmark_tags(bookmark_id:)
    DatabaseConnection.query("SELECT * FROM bookmark_tags WHERE bookmark_id=#{bookmark_id}")
        .map{ |record| Tag.new(id: record['id'], content: record['bookmark_id']) }
  end

end

# TODO: Create 'save' method to store the 'add'ed bookmarks to bookmark_tags table
# TODO: Complete the query from_bookmark_tags to return list of all tags for a particular bookmark
