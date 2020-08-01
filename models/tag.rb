require_relative './database_script'
require_relative './bookmark_tags'

class Tag
  attr_reader :content, :id, :bookmark_id

  def initialize(content:, id:)
    @id = id
    @content = content
  end

  def self.add(content:)
    DatabaseConnection.query("INSERT INTO tags (content) VALUES('#{content}') RETURNING *")
        .map{ |record| return Tag.new(content: record['content'], id: record['id']) } # beware of return
  end

  def self.on_bookmark(bookmark_id:)
    DatabaseConnection.query("SELECT * FROM tags WHERE id IN (SELECT id FROM bookmark_tags WHERE bookmark_id=#{bookmark_id})")
        .map{ |record| Tag.new(id: record['id'], content: record['content']) }
  end

end