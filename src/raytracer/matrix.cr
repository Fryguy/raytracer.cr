module Raytracer
  class Matrix
    getter order : Int32
    getter content : Array(Float64)

    def initialize(order)
      initialize(order, Array(Float64).new(order * order))
    end

    def initialize(@order, content)
      raise ArgumentError.new("content must be m x m in size") if content.size != order * order

      @content = content.map &.to_f
    end

    def [](row, col)
      raise IndexError.new("row index out of bounds") unless 0 <= row < order
      raise IndexError.new("col index out of bounds") unless 0 <= col < order

      content[row * order + col]
    end

    def ==(other)
      content.each_with_index.all? { |v, i| (v - other.content[i]).abs < EPSILON }
    end
  end
end
