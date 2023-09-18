module Raytracer
  record Tuple, x : Float64, y : Float64, z : Float64, w : Float64 do
    def self.new(x : Float64, y : Float64, z : Float64, w : Float64)
      raise ArgumentError.new("w-value can only be 0.0 or 1.0") unless w == 0.0 || w == 1.0
      previous_def
    end

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
  end
end
