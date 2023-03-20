require 'thor'
require 'colorize'
require_relative 'memo'

class CLI < Thor
  desc "list", "list all memos"
  def list
    memos = Memo.new.all
    memos.each do |memo|
      puts "#{memo[0]}. #{memo[1]}: #{memo[2]}"
    end
  end

  desc "add TITLE BODY", "add a new memo"
  def add(title, body)
    Memo.new.add(title, body)
    puts "Added new memo: #{title}".colorize(:green)
  end

  desc "delete", "delete memo ID"
  def delete(id)
    Memo.new.delete(id)
    puts "Deleted the memo: #{id}".colorize(:green)
  end
end

CLI.start(ARGV)
