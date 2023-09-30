require "./tuple"

module Raytracer
  class Matrix
    @@identity : self?

    def self.identity
      @@identity ||= new(4, [1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1])
    end

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

    def *(other : Matrix)
      new_content =
        (0...content.size).map do |i|
          r, c = i.divmod(order)
          # TODO: Perhaps use Tuple#dot?
          (0...order).sum do |i|
            self[r, i] * other[i, c]
          end
        end

      self.class.new(order, new_content)
    end

    def *(other : Tuple)
      x, y, z, w =
        (0...order).map do |r|
          (0...order).sum do |i|
            self[r, i] * other[i]
          end
        end

      Raytracer::Tuple.new(x, y, z, w)
    end
  end
end
