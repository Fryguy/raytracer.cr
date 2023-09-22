module Raytracer
  record Color, red : Float64, green : Float64, blue : Float64 do
    def ==(other)
      return false unless other.is_a?(self)

      (red - other.red).abs < EPSILON &&
        (green - other.green).abs < EPSILON &&
        (blue - other.blue).abs < EPSILON
    end
  end
end
