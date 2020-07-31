require_relative './database_script'

class Tag

  def self.add(content)
    DatabaseConnection.query("INSERT INTO tags (content) VALUES('#{content}') RETURNING *")
  end

end

