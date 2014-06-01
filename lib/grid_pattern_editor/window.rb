require "gosu"
require "grid_pattern_editor/base"
require "grid_pattern_editor/z_order"
require "grid_pattern_editor/board"
require "grid_pattern_editor/control_panel"
require "grid_pattern_editor/message"

module GridPatternEditor
  class Window < Gosu::Window
    attr_reader :images, :texts
    attr_reader :n_columns, :n_rows
    attr_reader :default_text

    attr_accessor :current_text

    def initialize(file_path=nil, options={})
      width     = options[:width]   || 800
      height    = options[:height]  || 600
      n_columns = options[:columns] || 24
      n_rows    = options[:rows]    || 32
      @default_text = options[:default_text] || "0"
      @current_text = nil
      super(width, height, false)
      description = file_path || "not set a file"
      self.caption = "Grid Pattern Editor - #{description}"
      init_texts
      init_images
      board_width = width * 0.8
      control_panel_width = width * 0.2
      @file_path = file_path
      @n_columns = n_columns
      @n_rows = n_rows
      @board = Board.new(self, board_width, height, file_path)
      @control_panel = ControlPanel.new(self,
                                        board_width, 0,
                                        control_panel_width, height)
      @message = nil
    end

    def update
      if @message
        @message.update
        @message = nil if @message.limit && @message.limit < 0
      end
    end

    def draw
      @board.draw
      @control_panel.draw
      @message.draw if @message
    end

    def button_down(id)
      case id
      when Gosu::MsLeft
        clicked_cell = @control_panel.clicked_cell
        if clicked_cell
          clicked_cell.run
        end
        clicked_cell = @board.clicked_cell
        return unless clicked_cell
        update_cell(clicked_cell)
      when Gosu::MsRight
        clicked_cell = @board.clicked_cell
        return unless clicked_cell
        update_cell(clicked_cell)
      when Gosu::KbEnter, Gosu::KbReturn
        puts(@board.to_s)
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
        @message = Message.new(self, "saved")
      end
    end

    def read_data
      data = []
      if @file_path && File.exist?(@file_path)
        begin
          File.open(@file_path) do |file|
            file.each_line do |line|
              data << line.split(//)
            end
          end
        rescue
          $stderr.puts("Warning: can't load file: #{@file_path}")
        end
      end
      data
    end

    private
    def init_texts
      @texts = [@default_text]
      Dir.glob("#{images_dir}/*").sort.each do |path|
        @texts << File.basename(path)[0]
      end
    end

    def init_images
      @images = {}
      @texts.each do |text|
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

    def update_cell(clicked_cell)
      if @current_text
        text = @current_text
      else
        text = @default_text
      end
      clicked_cell.set_image_from_text(text)
    end
  end
end
