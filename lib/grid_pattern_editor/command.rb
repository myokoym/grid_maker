require "grid_pattern_editor/window"

module GridPatternEditor
  class Command
    class << self
      def run
        window = Window.new
        window.show
      end
    end
  end
end
