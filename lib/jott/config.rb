# frozen_string_literal: true

class Config
  attr_reader :editor

  def initialize
    @file_path = File.join(File.dirname(__FILE__).to_s, 'jott.config')
    File.new(@file_path, 'w') unless File.exist?(@file_path)
    @editor = get_editor
  end

  def get_editor
    File.open(@file_path, 'r') do |file|
      file.each_line do |line|
        return line.split(':')[1].strip if line.include?('editor')
      end
    end
    'vi'
  end

  def set_editor(editor)
    File.open(@file_path, 'w') do |file|
      file.puts "editor: #{editor}"
    end
    @editor = editor
  end
end
