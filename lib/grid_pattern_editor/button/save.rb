require "gosu"
require "grid_pattern_editor/base"
require "grid_pattern_editor/z_order"

module GridPatternEditor
  module Button
    class Save < Cell
      include Base

      attr_reader :x, :y

      def initialize(window,
                     x, y,
                     width, height,
                     x_margin=0,
                     y_margin=0)
        @window = window
        @x = x
        @y = y
        @width = width
        @height = height
        @x1 = @x
        @y1 = @y
        @x2 = @x1 + @width
        @y2 = @y1 + @height
        @frame_color = Gosu::Color::BLACK
        @background_color = Gosu::Color::WHITE
        @image = Gosu::Image.from_text(@window,
                                       "Save",
                                       Gosu.default_font_name,
                                       (@height * 1.0).floor,
                                       0,
                                       (@width * 1.0).floor,
                                       :center)
        @image_factor_x = 1.0 * @width / @image.width
        @image_factor_y = 1.0 * @height / @image.height
      end

      def pointing?(x, y)
        @x1 < x && @x2 > x &&
        @y1 < y && @y2 > y
      end

      def run
        @window.write_data
        @window.message = Message.new(@window, "saved")
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
        color = Gosu::Color::BLACK
        @image.draw(x, y, z,
                    @image_factor_x, @image_factor_y,
                    color)
      end
    end
  end
end
