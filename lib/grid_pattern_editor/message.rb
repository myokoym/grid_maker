require "gosu"
require "grid_pattern_editor/base"
require "grid_pattern_editor/z_order"

module GridPatternEditor
  class Message
    include Base

    attr_reader :x, :y
    attr_reader :limit

    def initialize(window, text, limit=120)
      @window = window
      @text = text
      @width = @window.width / 5
      @height = @window.height / 10
      @x = @window.width / 2 - @width
      @y = @window.height / 2 - @height
      @x1 = @x
      @y1 = @y
      @x2 = @x1 + @width
      @y2 = @y1 + @height
      @frame_color = Gosu::Color::WHITE
      @background_color = Gosu::Color::BLACK
      @image = Gosu::Image.from_text(@window,
                                     @text,
                                     Gosu.default_font_name,
                                     (@height * 1.0).floor,
                                     0,
                                     (@width * 1.0).floor,
                                     :center)
      @image_factor_x = 1.0 * @width / @image.width
      @image_factor_y = 1.0 * @height / @image.height
      @limit = limit
    end

    def update
      return unless @limit
      @limit -= 1
    end

    def draw
      draw_background
      draw_text
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

    def draw_text
      x = @x1
      y = @y1
      z = ZOrder::Image
      color = Gosu::Color::WHITE
      @image.draw(x, y, z,
                  @image_factor_x, @image_factor_y,
                  color)
    end
  end
end
