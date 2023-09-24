module Raytracer
  class Canvas
    getter width : Int64
    getter height : Int64
    getter canvas : Array(Color)

    def initialize(@width, @height, color = Color.new(0, 0, 0))
      @canvas = Array.new(@width * @height) { color }
    end

    def []=(x, y, value)
      raise IndexError.new("x index out of bounds") unless 0 <= x < width
      raise IndexError.new("y index out of bounds") unless 0 <= y < height

      canvas[y * width + x] = value
    end

    def [](x, y)
      raise IndexError.new("x index out of bounds") unless 0 <= x < width
      raise IndexError.new("y index out of bounds") unless 0 <= y < height

      canvas[y * width + x]
    end

    def to_ppm(io)
      io << "P3\n"
      io << width << ' ' << height << '\n'
      io << "255\n"

      row_io = String::Builder.new
      canvas.each_with_index do |p, i|
        r, g, b = p.to_rgb
        row_io << r << ' ' << g << ' ' << b << ' '

        if i > 0 && (i + 1) % width == 0
          row = row_io.to_s.rstrip
          row_io = String::Builder.new

          # Split a single row into 70 char chunks
          while row.size > 70
            index = 69
            until row[index] == ' '
              index -= 1
            end

            io << row[..index - 1] << '\n'
            row = row[index + 1..]
          end

          io << row << '\n'
        end
      end
    end

    def to_ppm
      String.build do |io|
        to_ppm(io)
      end
    end
  end
end
