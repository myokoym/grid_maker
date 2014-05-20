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
      @font = Gosu::Font.new(@window, Gosu.default_font_name, @height / 12)
      create_cells
    end

    def draw
      draw_background
      draw_size_info
      @cells.each do |cell|
        cell.draw
      end
    end

    def click
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

    def create_cells
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
