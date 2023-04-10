require 'colorize'
require 'thor'
require_relative 'memo'
require_relative 'version'

class CLI < Thor
  desc "clear", "clear all memos"
  method_option :aliases => "-cl"
  def clear
    Memo.new.clear
    puts "Clear all memos".colorize(:green)
  end

  desc "add", "Add a new memo"
  def add(*str)
    text = str.join(" ")
    title = text[0, 30]
    Memo.new.create(title:, body: text)
    puts "Added new memo: #{title}".colorize(:green)
  end

  desc "delete", "delete memo ID"
  def rm(id)
    Memo.new.delete(id:)
    puts "Deleted the memo: #{id}".colorize(:green)
  end

  desc "list", "list all memos"
  def ls
    memos = Memo.new.all
    memos.each do |memo|
      puts "#{memo[0]}. #{memo[1]}: #{memo[2]}"
    end
  end

  desc "version", "show version"
  def version
    puts "jott version #{Jott::VERSION}"
  end
end

CLI.start(ARGV)
