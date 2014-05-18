require "grid_maker"

class WindowTest < Test::Unit::TestCase
  def setup
    @window = GridMaker::Window.new
  end

  def test_init
    assert_not_nil(@window)
  end
end
