module Raytracer
  class Canvas
    getter width : Int64
    getter height : Int64
    getter canvas : Array(Color)

    def initialize(@width, @height)
      @canvas = Array.new(@width * @height) { Color.new(0, 0, 0) }
    end

    def write_pixel(x, y, value)
      raise IndexError.new("x index out of bounds") unless 0 <= x < width
      raise IndexError.new("y index out of bounds") unless 0 <= y < height

      canvas[y * width + x] = value
    end

    def pixel_at(x, y)
      raise IndexError.new("x index out of bounds") unless 0 <= x < width
      raise IndexError.new("y index out of bounds") unless 0 <= y < height

      canvas[y * width + x]
    end
  end
end
