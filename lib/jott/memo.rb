require 'sqlite3'

class Memo
  def initialize
    @db = SQLite3::Database.new(File.join(File.dirname(__FILE__), "jott.db"))
    @db.execute("CREATE TABLE IF NOT EXISTS memos(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, body TEXT)")
  end

  def all
    @db.execute("SELECT * FROM memos")
  end

  def clear
    @db.execute("DROP TABLE memos")
  end

  def count
    @db.execute("SELECT COUNT(id) FROM memos")
  end

  def create(title:, body:)
    @db.execute("INSERT INTO memos(title, body) VALUES (?, ?)", [title, body])
  end

  def delete(id:)
    @db.execute("DELETE FROM memos WHERE id = ?", id)
  end

  def last
    @db.execute("SELECT max(id), * FROM memos")
  end
end
