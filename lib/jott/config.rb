class Config
  attr_reader :editor

  def initialize
    @file_path = File.join("#{File.dirname(__FILE__)}", "jott.config")
    unless File.exist?(@file_path)
      File.new(@file_path, "w")
    end
    @editor = get_editor
  end

  def get_editor
    File.open(@file_path, "r") do |file|
      file.each_line do |line|
        if line.include?("editor")
          return line.split(":")[1].strip
        else
          return "vi"
        end
      end
    end
  end

  def set_editor(editor)
    File.open(@file_path, "w") do |file|
      file.puts "editor: #{editor}"
    end
    @editor = editor
  end
end
