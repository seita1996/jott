require 'sqlite3'

class Memo
  def initialize
    @db = SQLite3::Database.new("memo.db")
    @db.execute("CREATE TABLE IF NOT EXISTS memos(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, body TEXT)")
  end

  def all
    @db.execute("SELECT * FROM memos")
  end

  def add(title, body)
    @db.execute("INSERT INTO memos(title, body) VALUES (?, ?)", [title, body])
  end

  def delete(id)
    @db.execute("DELETE FROM memos WHERE id = ?", id)
  end
end
