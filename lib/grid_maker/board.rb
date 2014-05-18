require "gosu"
require "grid_maker/base"
require "grid_maker/z_order"
require "grid_maker/cell"

module GridMaker
  class Board
    include Base

    attr_reader :cell_hash

    def initialize(window, width, height)
      @window = window
      @width = width
      @height = height
      @cells = []
      @cell_hash = {}
      create_cells
    end

    def draw
      draw_background
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

    def reset
      @cells = []
      create_cells
      @cell_hash = {}
      @cells.each {|cell| cell.close }
    end

    def to_s
      lines = 0.upto(@num_of_row - 1).collect do |y|
        line = 0.upto(@num_of_column - 1).collect do |x|
          @cell_hash["#{y}#{x}"].text
        end
        line.join
      end
      lines.join("\n")
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
      width = 29
      height = 29
      x_margin = @width % width
      y_margin = @height % height
      @num_of_column = (@width - x_margin) / width
      @num_of_row = (@height - y_margin) / height
      0.upto(@num_of_row - 1) do |y|
        0.upto(@num_of_column - 1) do |x|
          cell = Cell.new(@window,
                          x, y,
                          width, height,
                          x_margin / 2,
                          y_margin / 2)
          @cells << cell
          @cell_hash["#{y}#{x}"] = cell
        end
      end
    end
  end
end
