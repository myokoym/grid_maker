require "grid_pattern_editor"

class WindowTest < Test::Unit::TestCase
  def setup
    @window = GridPatternEditor::Window.new
  end

  def test_init
    assert_not_nil(@window)
  end
end
