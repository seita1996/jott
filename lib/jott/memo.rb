# frozen_string_literal: true

require 'sqlite3'

class Memo
  def initialize
    @db = SQLite3::Database.new(File.join(File.dirname(__FILE__), 'jott.db'))
    @db.execute('CREATE TABLE IF NOT EXISTS memos(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, body TEXT)')
  end

  def all
    @db.execute('SELECT * FROM memos')
  end

  def clear
    @db.execute('DROP TABLE memos')
  end

  def count
    @db.execute('SELECT COUNT(id) FROM memos')
  end

  def create(title:, body:)
    title = title.gsub(/\n/, '')
    @db.execute('INSERT INTO memos(title, body) VALUES (?, ?)', [title, body])
  end

  def delete(id:)
    @db.execute('DELETE FROM memos WHERE id = ?', id)
  end

  def find(id)
    @db.execute('SELECT * FROM memos WHERE id = ?', id)
  end

  def last
    @db.execute('SELECT max(id), * FROM memos')
  end

  def update(id:, title:, body:)
    title = title.gsub(/\n/, '')
    @db.execute('UPDATE memos SET title = ?, body = ? WHERE id = ?', [title, body, id])
  end
end
