module Raytracer
  class Matrix
    getter rows : Int32
    getter columns : Int32
    getter content : Array(Float64)

    def initialize(@rows, @columns)
      initialize(rows, columns, Array(Float64).new(rows * columns))
    end

    def initialize(@rows, @columns, content)
      raise ArgumentError.new("content must be rows x columns in size") if content.size != rows * columns

      @content = content.map &.to_f
    end

    def [](row, column)
      raise IndexError.new("row index out of bounds") unless 0 <= row < rows
      raise IndexError.new("column index out of bounds") unless 0 <= column < columns

      content[row * rows + column]
    end

    def ==(other)
      content.each_with_index.all? { |v, i| (v - other.content[i]).abs < EPSILON }
    end
  end
end
