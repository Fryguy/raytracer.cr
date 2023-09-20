module Raytracer
  record Tuple, x : Float64, y : Float64, z : Float64, w : Float64 do
    def self.point(x, y, z)
      new(x, y, z, 1.0)
    end

    def point?
      w == 1.0
    end
    
    def self.vector(x, y, z)
      new(x, y, z, 0.0)
    end

    def vector?
      w == 0.0
    end

    def +(other)
      self.class.new(x + other.x, y + other.y, z + other.z, w + other.w)
    end

    def -(other)
      self.class.new(x - other.x, y - other.y, z - other.z, w - other.w)
    end

    def -
      self.class.new(-x, -y, -z, -w)
    end

    def *(value : Float64)
      self.class.new(x * value, y * value, z * value, w * value)
    end

    def /(value : Float64)
      self.class.new(x / value, y / value, z / value, w / value)
    end
  end
end
