require 'colorize'
require 'tempfile'
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
    if str.empty? # open text editor
      tempfile = Tempfile.new
      system("vim", tempfile.path)
      text = File.read(tempfile.path)
      tempfile.unlink
    else # add memo from command line
      text = str.join(" ")
    end
    title = text[0, 30]
    Memo.new.create(title:, body: text)
    puts "Added new memo: #{title}".colorize(:green)
  end

  desc "delete", "delete memo ID"
  def rm(id)
    Memo.new.delete(id:)
    puts "Deleted the memo: #{id}".colorize(:green)
  end

  desc "edit", "open the memo with text editor and update"
  def edit(*args)
    id = args.first
    id = Memo.new.last[0][0] if id.nil?
    str = args[1..-1]
    memo = Memo.new.find(id)

    if str.nil? || str.empty? # open text editor
      tempfile = Tempfile.new
      File.open(tempfile.path, "w") do |f|
        f.puts memo[0][2]
      end
      system("vim", tempfile.path)
      data = File.read(tempfile.path)
      Memo.new.update(id: id, title: data[0, 30], body: data)
      tempfile.unlink
      puts "Edited the memo: #{id}".colorize(:green)
    else # add memo from command line
      text = str.join(" ")
      title = text[0, 30]
      Memo.new.update(id: id, title: title, body: text)
      puts "Edited the memo: #{id}".colorize(:green)
    end
  end

  desc "list", "list all memos"
  def ls
    memos = Memo.new.all
    memos.each do |memo|
      puts "#{memo[0]}. #{memo[1]}: #{memo[2]}"
    end
  end

  desc "show", "show memo ID"
  def show(id)
    memo = Memo.new.find(id)
    puts "#{memo[0][2]}"
  end

  desc "version", "show version"
  def version
    puts "jott version #{Jott::VERSION}"
  end
end

CLI.start(ARGV)
