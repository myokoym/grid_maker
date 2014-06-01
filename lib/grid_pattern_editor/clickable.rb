module GridPatternEditor
  module Clickable
    def pointing?(x, y)
      @x1 < x && @x2 > x &&
      @y1 < y && @y2 > y
    end
  end
end
