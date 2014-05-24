require "gosu"
require "grid_pattern_editor/base"
require "grid_pattern_editor/z_order"

module GridPatternEditor
  class Cell
    include Base

    DEFAULT_TEXT = "0"

    attr_reader :x, :y
    attr_reader :text

    def initialize(window,
                   x, y,
                   width, height,
                   x_margin=0,
                   y_margin=0,
                   text=nil)
      @window = window
      @x = x
      @y = y
      @width = width
      @height = height
      @x1 = x_margin + @x * @width
      @y1 = y_margin + @y * @height
      @x2 = @x1 + @width
      @y2 = @y1 + @height
      @text = text || DEFAULT_TEXT
      @frame_color = Gosu::Color::BLACK
      @background_color = Gosu::Color::WHITE
      set_image_from_text(@text)
    end

    def set_image_from_text(text)
      @window.images
      @text = text
      @image = @window.images[@text]
      return unless @image
      @image_factor_x = @width.to_f / @image.width
      @image_factor_y = @height.to_f / @image.height
    end

    def remove
      @text = DEFAULT_TEXT
    end

    def pointing?(x, y)
      @x1 < x && @x2 > x &&
      @y1 < y && @y2 > y
    end

    def draw
      draw_background
      draw_image if @image
    end

    def draw_background
      draw_square(@window,
                  @x1, @y1,
                  @x2, @y2,
                  @background_color,
                  ZOrder::Cell)
      draw_frame(@window,
                 @x1, @y1,
                 @x2, @y2,
                 @frame_color,
                 ZOrder::Frame)
    end

    def draw_image
      x = @x1
      y = @y1
      z = ZOrder::Image
      @image.draw(x, y, z,
                  @image_factor_x, @image_factor_y)
    end
  end
end
