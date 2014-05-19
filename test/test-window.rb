require "grid_pattern_editor"

class WindowTest < Test::Unit::TestCase
  def setup
    @window = GridPatternEditor::Window.new
  end

  def test_init
    assert_not_nil(@window)
  end

  def test_accept_output_file
    window = GridPatternEditor::Window.new("grid_pattern.txt")
    assert_not_nil(window)
  end

  def test_caption
    assert_equal("Grid Pattern Editor - not set a file", @window.caption)
  end
end
