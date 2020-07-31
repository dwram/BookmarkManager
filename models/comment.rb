require_relative './database_script'

class Comment
  attr_reader :text, :bookmark_id, :id

  def initialize(id:,text:, bookmark_id:)
    @id = id
    @text = text
    @bookmark_id = bookmark_id
  end

  def self.add(comment:, bookmark_id:)
    DatabaseConnection.query("INSERT INTO comments (text, bookmark_id) VALUES('#{comment}',#{bookmark_id}) RETURNING id, text, bookmark_id")
  end

  def self.all
    DatabaseConnection.query('SELECT id, text, bookmark_id FROM comments').map{ |record| Comment.new(text: record['text'], bookmark_id: record['bookmark_id'], id: record['id'])}
  end

  def self.from_bookmark(bookmark_id:)
    DatabaseConnection.query("SELECT id, text, bookmark_id FROM comments WHERE bookmark_id=#{bookmark_id}")
                  .map{ |record|
                    Comment.new(id: record['id'], bookmark_id: record['bookmark_id'], text: record['text']) }
  end

end
