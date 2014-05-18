module GridMaker
  module Base
    def draw_square(window, x1, y1, x2, y2, color, z_order=0)
      window.draw_quad(x1, y1, color,
                       x2, y1, color,
                       x1, y2, color,
                       x2, y2, color,
                       z_order)
    end

    def draw_frame(window, x1, y1, x2, y2, color, z_order=0)
      window.draw_line(x1, y1, color,
                       x2, y1, color,
                       z_order)
      window.draw_line(x1, y1, color,
                       x1, y2, color,
                       z_order)
      window.draw_line(x1, y2, color,
                       x2, y2, color,
                       z_order)
      window.draw_line(x2, y1, color,
                       x2, y2, color,
                       z_order)
    end
  end
end
