require 'thor'
require 'colorize'
require_relative 'memo'

class CLI < Thor
  desc "clear", "clear all memos"
  def clear
    Memo.new.clear
    puts "Clear all memos".colorize(:green)
  end

  desc "create", "create a new memo"
  def create(text)
    title = text[0, 30]
    Memo.new.create(title:, body: text)
    puts "Created new memo: #{title}".colorize(:green)
  end

  desc "delete", "delete memo ID"
  def delete(id)
    Memo.new.delete(id:)
    puts "Deleted the memo: #{id}".colorize(:green)
  end

  desc "list", "list all memos"
  def list
    memos = Memo.new.all
    memos.each do |memo|
      puts "#{memo[0]}. #{memo[1]}: #{memo[2]}"
    end
  end
end

CLI.start(ARGV)
