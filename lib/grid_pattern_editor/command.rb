require "grid_pattern_editor/window"

module GridPatternEditor
  class Command
    class << self
      def run(*arguments)
        window = Window.new(arguments[0])
        window.show
      end
    end
  end
end
