require "gosu"
require "grid_pattern_editor/base"
require "grid_pattern_editor/z_order"
require "grid_pattern_editor/cell"
require "grid_pattern_editor/button"

module GridPatternEditor
  class ControlPanel < Board
    include Base

    def initialize(window, x, y, width, height)
      @window = window
      @x = x
      @y = y
      @width = width
      @height = height
      @cells = []
      @font_size = @height / 18
      @font = Gosu::Font.new(@window, Gosu.default_font_name, @font_size)
      create_save_button
      create_text_witn_images
    end

    def draw
      draw_background
      draw_size_info
      @cells.each do |cell|
        cell.draw
      end
      draw_current_text_with_image
    end

    def clicked_cell
      @cells.each do |cell|
        if cell.pointing?(@window.mouse_x, @window.mouse_y)
          return cell
        end
      end
      nil
    end

    private
    def draw_background
      draw_square(@window,
                  @x, @y,
                  @x + @width, @y + @height,
                  Gosu::Color::GRAY,
                  ZOrder::Background)
    end

    def draw_size_info
      @font.draw("#{@window.n_columns} * #{@window.n_rows}",
                 @x * 1.0, @y * 1.0, ZOrder::Image,
                 1.0, 1.0, Gosu::Color::BLACK)
    end

    def draw_current_text_with_image
      x = @x + @font_size * 0.1
      y = @y + @font_size * 2
      if @window.current_text
        draw_current_text(@window.current_text, x, y)
        image = @window.images[@window.current_text]
        image.draw(x + @font_size * 2.5,
                   y,
                   ZOrder::Image,
                   @font_size.to_f / image.width,
                   @font_size.to_f / image.height)
      else
        draw_current_text(@window.default_text, x, y)
      end
    end

    def draw_current_text(text, x, y)
      @font.draw("set: #{text}",
                 x,
                 y,
                 ZOrder::Image,
                 1.0, 1.0, Gosu::Color::BLACK)
    end

    def create_text_witn_images
      x = @x + @font_size * 0.1
      @window.images.each_with_index do |entry, i|
        y = @y + @font_size * 3 + @font_size * (i + 1)
        width = @width * 0.45
        height = @font_size
        text, image = *entry
        cell = Button::TextWithImage.new(@window,
                                         x, y,
                                         width, height,
                                         text,
                                         image)
        @cells << cell
      end
    end

    def create_save_button
      x = @x * 1.02
      y = @window.height * 0.9
      width = @width * 0.8
      height = @height * 0.08
      cell = Button::Save.new(@window,
                              x, y,
                              width, height)
      @cells << cell
    end
  end
end
