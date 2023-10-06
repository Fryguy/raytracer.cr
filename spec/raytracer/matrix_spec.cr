describe Raytracer::Matrix do
  describe ".new" do
    it "creates a 4x4 matrix" do
      m = Raytracer::Matrix.new(4,
        [
          1, 2, 3, 4,
          5.5, 6.5, 7.5, 8.5,
          9, 10, 11, 12,
          13.5, 14.5, 15.5, 16.5,
        ]
      )
      m[0, 0].should eq 1
      m[0, 3].should eq 4
      m[1, 0].should eq 5.5
      m[1, 2].should eq 7.5
      m[2, 2].should eq 11
      m[3, 0].should eq 13.5
      m[3, 2].should eq 15.5
    end

    it "creates a 2x2 matrix" do
      m = Raytracer::Matrix.new(2,
        [
          -3, 5,
          1, -2,
        ]
      )
      m[0, 0].should eq -3
      m[0, 1].should eq 5
      m[1, 0].should eq 1
      m[1, 1].should eq -2
    end

    it "creates a 3x3 matrix" do
      m = Raytracer::Matrix.new(3,
        [
          -3, 5, 0,
          1, -2, -7,
          0, 1, 1,
        ]
      )
      m[0, 0].should eq -3
      m[0, 1].should eq 5
      m[1, 0].should eq 1
      m[1, 1].should eq -2
    end

    it "raises on content too large" do
      expect_raises(ArgumentError) do
        Raytracer::Matrix.new(2,
          [
            -3, 5,
            1, -2,
            0,
          ]
        )
      end
    end

    it "raises on content too small" do
      expect_raises(ArgumentError) do
        Raytracer::Matrix.new(2,
          [
            -3, 5,
            1,
          ]
        )
      end
    end
  end

  describe ".identity" do
    it "returns the identity matrix" do
      Raytracer::Matrix.identity.should eq Raytracer::Matrix.new(4,
        [
          1, 0, 0, 0,
          0, 1, 0, 0,
          0, 0, 1, 0,
          0, 0, 0, 1,
        ]
      )
    end
  end

  describe "#[]" do
    it "raises on out of bounds reads" do
      m = Raytracer::Matrix.new(2,
        [
          -3, 5,
          1, -2,
        ]
      )
      expect_raises(IndexError) { m[-1, 0] }
      expect_raises(IndexError) { m[2, 0] }
      expect_raises(IndexError) { m[0, -1] }
      expect_raises(IndexError) { m[0, 2] }
    end
  end

  describe "#==" do
    it "with identical matrices" do
      m1 = Raytracer::Matrix.new(4,
        [
          1, 2, 3, 4,
          5, 6, 7, 8,
          9, 8, 7, 6,
          5, 4, 3, 2,
        ]
      )
      m2 = Raytracer::Matrix.new(4,
        [
          1, 2, 3, 4,
          5, 6, 7, 8,
          9, 8, 7, 6,
          5, 4, 3, 2,
        ]
      )
      m1.should eq m2
    end

    it "with different matrices" do
      m1 = Raytracer::Matrix.new(4,
        [
          1, 2, 3, 4,
          5, 6, 7, 8,
          9, 8, 7, 6,
          5, 4, 3, 2,
        ]
      )
      m2 = Raytracer::Matrix.new(4,
        [
          2, 3, 4, 5,
          6, 7, 8, 9,
          8, 7, 6, 5,
          4, 3, 2, 1,
        ]
      )
      m1.should_not eq m2
    end

    it "handles floating points within EPSILON" do
      m1 = Raytracer::Matrix.new(2,
        [
          0.33333, 0.33333,
          0.33333, 0.33333,
        ]
      )
      m2 = Raytracer::Matrix.new(2,
        [
          1.0 / 3.0, 1.0 / 3.0,
          1.0 / 3.0, 1.0 / 3.0,
        ]
      )
      m1.should eq m2
    end
  end

  describe "#*" do
    it "multiplies two matrices" do
      m1 = Raytracer::Matrix.new(4,
        [
          1, 2, 3, 4,
          5, 6, 7, 8,
          9, 8, 7, 6,
          5, 4, 3, 2,
        ]
      )
      m2 = Raytracer::Matrix.new(4,
        [
          -2, 1, 2, 3,
          3, 2, 1, -1,
          4, 3, 6, 5,
          1, 2, 7, 8,
        ]
      )
      m3 = m1 * m2
      m3.should eq Raytracer::Matrix.new(4,
        [
          20, 22, 50, 48,
          44, 54, 114, 108,
          40, 58, 110, 102,
          16, 26, 46, 42,
        ]
      )
    end

    it "multiplies with the identity matrix" do
      m1 = Raytracer::Matrix.new(4,
        [
          0, 1, 2, 4,
          1, 2, 4, 8,
          2, 4, 8, 16,
          4, 8, 16, 32,
        ]
      )
      m2 = m1 * Raytracer::Matrix.identity
      m2.should eq m1
    end

    it "multiplies a matrix with a Tuple" do
      m = Raytracer::Matrix.new(4,
        [
          1, 2, 3, 4,
          2, 4, 4, 2,
          8, 6, 4, 1,
          0, 0, 0, 1,
        ]
      )
      t1 = Raytracer::Tuple.new(1, 2, 3, 1)
      t2 = m * t1
      t2.should eq Raytracer::Tuple.new(18, 24, 33, 1)
    end
  end

  describe "#transpose" do
    it "transposes the matrix" do
      m1 = Raytracer::Matrix.new(4,
        [
          0, 9, 3, 0,
          9, 8, 0, 8,
          1, 8, 5, 3,
          0, 0, 5, 8,
        ]
      )
      m2 = Raytracer::Matrix.new(4,
        [
          0, 9, 1, 0,
          9, 8, 8, 0,
          3, 0, 5, 5,
          0, 8, 3, 8,
        ]
      )
      m1.transpose.should eq m2
    end

    it "transposes the identity matrix to itself" do
      Raytracer::Matrix.identity.transpose.should eq Raytracer::Matrix.identity
    end
  end

  describe "#determinant" do
    it "calculates the determinant of a 2x2 matrix" do
      m = Raytracer::Matrix.new(2,
        [
          1, 5,
          -3, 2,
        ]
      )
      m.determinant.should eq 17
    end

    it "only takes the determinant of a 2x2 matrix" do
      m = Raytracer::Matrix.new(3,
        [
          1, 5, 6,
          -3, 2, 7,
          8, 9, 0,
        ]
      )
      expect_raises(NotImplementedError) do
        m.determinant
      end
    end
  end
end
