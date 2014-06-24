require "gosu"
require "grid_pattern_editor/base"
require "grid_pattern_editor/z_order"
require "grid_pattern_editor/cell"

module GridPatternEditor
  class Board
    include Base

    attr_reader :cell_hash

    def initialize(window, width, height, file_path=nil)
      @window = window
      @width = width
      @height = height
      @cells = []
      @cell_hash = {}
      @n_columns = @window.n_columns
      @n_rows = @window.n_rows
      @file_path = file_path
      create_cells
    end

    def draw
      draw_background
      @cells.each do |cell|
        cell.draw
      end
    end

    def click(text)
      handled = false
      @cells.each do |cell|
        if cell.pointing?(@window.mouse_x, @window.mouse_y)
          cell.set_image_from_text(text)
          x = cell.x + @window.scroll_position_x
          y = cell.y + @window.scroll_position_y
          @window.data[y][x] = text
          handled = true
        end
      end
      handled
    end

    def to_s
      lines = @window.data.collect do |line|
        line.join.chomp
      end
      lines.join("\n")
    end

    def scroll_x
      data = @window.data
      scroll_position = @window.scroll_position_x
      0.upto(@n_rows - 1) do |y|
        0.upto(@n_columns - 1) do |x|
          data_x = x + scroll_position
          text = data[y][data_x]
          cell = @cell_hash["#{y}-#{x}"]
          cell.set_image_from_text(text)
        end
      end
    end

    def scroll_y
      data = @window.data
      scroll_position = @window.scroll_position_y
      0.upto(@n_rows - 1) do |y|
        0.upto(@n_columns - 1) do |x|
          data_y = y + scroll_position
          text = data[data_y][x]
          cell = @cell_hash["#{y}-#{x}"]
          cell.set_image_from_text(text)
        end
      end
    end

    private
    def draw_background
      draw_square(@window,
                  0, 0,
                  @width, @height,
                  Gosu::Color::BLACK,
                  ZOrder::Background)
    end

    def create_cells
      width = @width * 0.98 / @n_columns
      height = @height * 0.98 / @n_rows
      x_margin = @width % width
      y_margin = @height % height
      data = @window.read_data
      0.upto(@n_rows - 1) do |y|
        0.upto(@n_columns - 1) do |x|
          text = data[y] ? data[y][x] : nil
          cell = Cell.new(@window,
                          x, y,
                          width, height,
                          x_margin / 2,
                          y_margin / 2,
                          text)
          @cells << cell
          @cell_hash["#{y}-#{x}"] = cell
        end
      end
    end
  end
end
