require "grid_pattern_editor/command"
require "grid_pattern_editor/window"

class CommandTest < Test::Unit::TestCase
  # FIXME
  class GridPatternEditor::Window
    def draw
    end

    def show
      self
    end
  end

  def test_width_short
    arguments = [
      "data.txt",
      "-w", "100",
    ]
    window = GridPatternEditor::Command.run(*arguments)
    assert_equal(100, window.width)
  end

  def test_width_long
    arguments = [
      "data.txt",
      "--width=100",
    ]
    window = GridPatternEditor::Command.run(*arguments)
    assert_equal(100, window.width)
  end

  def test_height_short
    arguments = [
      "data.txt",
      "-h", "100",
    ]
    window = GridPatternEditor::Command.run(*arguments)
    assert_equal(100, window.height)
  end

  def test_height_long
    arguments = [
      "data.txt",
      "--height=100",
    ]
    window = GridPatternEditor::Command.run(*arguments)
    assert_equal(100, window.height)
  end

  def test_columns
    arguments = [
      "data.txt",
      "--columns=10",
    ]
    window = GridPatternEditor::Command.run(*arguments)
    assert_equal(10, window.n_columns)
  end

  def test_rows
    arguments = [
      "data.txt",
      "--rows=10",
    ]
    window = GridPatternEditor::Command.run(*arguments)
    assert_equal(10, window.n_rows)
  end
end
