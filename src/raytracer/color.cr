module Raytracer
  record Color, red : Float64, green : Float64, blue : Float64 do
    def ==(other)
      return false unless other.is_a?(self)

      (red - other.red).abs < EPSILON &&
        (green - other.green).abs < EPSILON &&
        (blue - other.blue).abs < EPSILON
    end

    def +(other)
      self.class.new(red + other.red, green + other.green, blue + other.blue)
    end

    def -(other)
      self.class.new(red - other.red, green - other.green, blue - other.blue)
    end

    def *(value : Float64)
      self.class.new(red * value, green * value, blue * value)
    end

    def *(other : self)
      self.class.new(red * other.red, green * other.green, blue * other.blue)
    end

    def to_rgb
      return (red * 255).round.to_i.clamp(0, 255),
        (green * 255).round.to_i.clamp(0, 255),
        (blue * 255).round.to_i.clamp(0, 255)
    end
  end
end
