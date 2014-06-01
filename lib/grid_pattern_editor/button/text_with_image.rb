require "gosu"
require "grid_pattern_editor/base"
require "grid_pattern_editor/z_order"
require "grid_pattern_editor/clickable"

module GridPatternEditor
  module Button
    class TextWithImage
      include Base
      include Clickable

      attr_reader :x, :y

      def initialize(window,
                     x, y,
                     width, height,
                     text,
                     image)
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
        @text = text
        @image = image
        @font_size = (@height * 0.95).round
        @font = Gosu::Font.new(@window, Gosu.default_font_name, @font_size)
        @image_factor_x = @font_size.to_f / @image.width
        @image_factor_y = @font_size.to_f / @image.height
      end

      def run
      end

      def draw
        draw_background
        draw_image
        draw_text
      end

      private
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
        @font.draw(": #{@text}",
                   @x + @font_size,
                   @y,
                   ZOrder::Image,
                   1.0, 1.0, Gosu::Color::BLACK)
      end

      def draw_image
        @image.draw(@x,
                    @y,
                    ZOrder::Image,
                    @image_factor_x,
                    @image_factor_y)
      end
    end
  end
end
