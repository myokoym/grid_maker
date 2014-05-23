require "gosu"
require "grid_pattern_editor/base"
require "grid_pattern_editor/z_order"
require "grid_pattern_editor/board"
require "grid_pattern_editor/control_panel"

module GridPatternEditor
  class Window < Gosu::Window
    TEXTS = [
      "0",
      "1",
      "2",
    ]

    attr_reader :images, :texts
    attr_reader :n_columns, :n_rows

    def initialize(file_path=nil, options={})
      width     = options[:width]   || 800
      height    = options[:height]  || 600
      n_columns = options[:columns] || 24
      n_rows    = options[:rows]    || 32
      super(width, height, false)
      description = file_path || "not set a file"
      self.caption = "Grid Pattern Editor - #{description}"
      init_images
      board_width = width * 0.8
      control_panel_width = width * 0.2
      @n_columns = n_columns
      @n_rows = n_rows
      @board = Board.new(self, board_width, height)
      @control_panel = ControlPanel.new(self,
                                        board_width, 0,
                                        control_panel_width, height)
      @file_path = file_path
    end

    def update
    end

    def draw
      @board.draw
      @control_panel.draw
    end

    def button_down(id)
      case id
      when Gosu::MsLeft
        clicked_cell = @control_panel.click
        if clicked_cell
          clicked_cell.run
        end
        clicked_cell = @board.click
        return unless clicked_cell
        index = TEXTS.index(clicked_cell.text)
        index += 1
        index %= TEXTS.size
        clicked_cell.set_image_from_text(TEXTS[index])
      when Gosu::KbEnter, Gosu::KbReturn
        write_data
      when Gosu::KbR
        @board.reset
      when Gosu::KbEscape
        close
      end
    end

    def needs_cursor?
      true
    end

    def write_data
      if @file_path.nil?
        puts(@board.to_s)
      else
        begin
          File.open(@file_path, "w") do |file|
            file.puts(@board.to_s)
          end
        rescue
          $stderr.puts("Warning: can't save file: #{@file_path}")
        end
      end
    end

    private
    def init_images
      @images = {}
      TEXTS.each do |text|
        image_path = File.join(images_dir, "#{text}.png")
        next unless File.exist?(image_path)
        image = Gosu::Image.new(self, image_path, false)
        @images[text] = image
      end
    end

    def images_dir
      File.join(media_dir, "images")
    end

    def media_dir
      base_dir = File.expand_path(File.join(__FILE__, "..", "..", ".."))
      File.join(base_dir, "media")
    end
  end
end
