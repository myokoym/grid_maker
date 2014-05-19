require "grid_pattern_editor/window"

module GridPatternEditor
  class Command
    class << self
      def run(*arguments)
        file_name = arguments[0]
        unless file_name
          $stderr.puts(<<-END_OF_MESSAGE)
Warning: not set an export/import file.
Usage: grid_pattern_editor [FILE_PATH]
          END_OF_MESSAGE
        end
        window = Window.new(file_name)
        window.show
      end
    end
  end
end
