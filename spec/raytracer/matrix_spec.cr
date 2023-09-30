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
end
