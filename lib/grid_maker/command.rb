require "grid_maker/window"

module GridMaker
  class Command
    class << self
      def run
        window = Window.new
        window.show
      end
    end
  end
end
