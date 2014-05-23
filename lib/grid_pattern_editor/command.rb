require "optparse"
require "grid_pattern_editor/window"

module GridPatternEditor
  class Command
    class << self
      def run(*arguments)
        options = parse_option(arguments)
        file_name = arguments[0]
        unless file_name
          $stderr.puts(<<-END_OF_MESSAGE)
Warning: not set an export/import file.
Usage: grid_pattern_editor [FILE_PATH]
          END_OF_MESSAGE
        end
        window = Window.new(file_name, options)
        window.show
      end

      def parse_option(arguments)
        options = {}

        parser = OptionParser.new

        parser.banner = "grid_pattern_editor [FILE_PATH] [OPTION]..."

        parser.on("-w", "--width=WIDTH",
                  Integer,
                  "Window width size (px)") do |width|
          options[:width] = width
        end

        parser.on("-h", "--height=HEIGHT",
                  Integer,
                  "Window height size (px)") do |height|
          options[:height] = height
        end

        parser.on("--columns=COLUMUNS",
                  Integer,
                  "Number of columns") do |columns|
          options[:columns] = columns
        end

        parser.on("--rows=ROWS",
                  Integer,
                  "Number of rows") do |rows|
          options[:rows] = rows
        end

        parser.parse!(arguments)

        options
      end
    end
  end
end
