require "gosu"
require "grid_pattern_editor/base"
require "grid_pattern_editor/z_order"
require "grid_pattern_editor/board"

module GridPatternEditor
  class Window < Gosu::Window
    TEXTS = [
      "0",
      "1",
      "2",
    ]

    attr_reader :images, :texts

    def initialize(file_name=nil, width=800, height=600)
      super(width, height, false)
      self.caption = "GridPatternEditor"
      init_images
      @board = Board.new(self, width, height)
      @file_name = file_name
    end

    def update
    end

    def draw
      @board.draw
    end

    def button_down(id)
      case id
      when Gosu::MsLeft
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

    def write_data
      if @file_name.nil?
        puts(@board.to_s)
      elsif File.exist?(@file_name)
        File.open(@file_name, "w") do |file|
          file.puts(@board.to_s)
        end
      else
        $stderr.puts("Warning: don't exist the file: #{@file_name}")
      end
    end
  end
end
