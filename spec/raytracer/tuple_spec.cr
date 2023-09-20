describe Raytracer::Tuple do
  describe ".new" do
    it "with w=1.0 is a point" do
      t = Raytracer::Tuple.new(4.3, -4.2, 3.1, 1.0)
      t.x.should eq 4.3
      t.y.should eq -4.2
      t.z.should eq 3.1
      t.w.should eq 1.0
      t.point?.should be_true
      t.vector?.should be_false
    end

    it "with w=0.0 is a vector" do
      t = Raytracer::Tuple.new(4.3, -4.2, 3.1, 0.0)
      t.x.should eq 4.3
      t.y.should eq -4.2
      t.z.should eq 3.1
      t.w.should eq 0.0
      t.vector?.should be_true
      t.point?.should be_false
    end

    it "creates a tuple with integers" do
      t = Raytracer::Tuple.new(4, -4, 3, 1)
      t.x.should eq 4.0
      t.y.should eq -4.0
      t.z.should eq 3.0
      t.w.should eq 1.0
      t.point?.should be_true
      t.vector?.should be_false
    end

    pending "when w is an illegal value" do
      expect_raises(ArgumentError) do
        Raytracer::Tuple.new(4, -4, 3, 3)
      end
    end
  end

  describe ".point" do
    it "creates a point" do
      t = Raytracer::Tuple.point(4.3, -4.2, 3.1)
      t.should be_a Raytracer::Tuple
      t.x.should eq 4.3
      t.y.should eq -4.2
      t.z.should eq 3.1
      t.w.should eq 1.0
    end

    it "creates a point with integers" do
      t = Raytracer::Tuple.point(4, -4, 3)
      t.should be_a Raytracer::Tuple
      t.x.should eq 4.0
      t.y.should eq -4.0
      t.z.should eq 3.0
      t.w.should eq 1.0
    end
  end

  describe ".point?" do
    it "with a point" do
      t = Raytracer::Tuple.point(4.3, -4.2, 3.1)
      t.point?.should be_true
    end

    it "with a vector" do
      t = Raytracer::Tuple.vector(4.3, -4.2, 3.1)
      t.point?.should be_false
    end
  end

  describe ".vector" do
    it "creates a vector" do
      t = Raytracer::Tuple.vector(4.3, -4.2, 3.1)
      t.should be_a Raytracer::Tuple
      t.x.should eq 4.3
      t.y.should eq -4.2
      t.z.should eq 3.1
      t.w.should eq 0.0
    end

    it "creates a vector with integers" do
      t = Raytracer::Tuple.vector(4, -4, 3)
      t.should be_a Raytracer::Tuple
      t.x.should eq 4.0
      t.y.should eq -4.0
      t.z.should eq 3.0
      t.w.should eq 0.0
    end
  end

  describe ".vector?" do
    it "with a vector" do
      t = Raytracer::Tuple.vector(4.3, -4.2, 3.1)
      t.vector?.should be_true
    end

    it "with a point" do
      t = Raytracer::Tuple.point(4.3, -4.2, 3.1)
      t.vector?.should be_false
    end
  end

  describe "#+" do
    it "can add 2 tuples" do
      t1 = Raytracer::Tuple.new(3, -2, 5, 1)
      t2 = Raytracer::Tuple.new(-2, 3, 1, 0)
      t3 = t1 + t2
      t3.should eq Raytracer::Tuple.new(1, 1, 6, 1)
    end

    it "can add a point and vector" do
      p = Raytracer::Tuple.point(3, -2, 5)
      v = Raytracer::Tuple.vector(-2, 3, 1)
      p2 = p + v
      p2.should eq Raytracer::Tuple.point(1, 1, 6)
    end

    it "can add 2 vectors" do
      v1 = Raytracer::Tuple.vector(3, -2, 5)
      v2 = Raytracer::Tuple.vector(-2, 3, 1)
      v3 = v1 + v2
      v3.should eq Raytracer::Tuple.vector(1, 1, 6)
    end

    pending "cannot add 2 points" do
      p1 = Raytracer::Tuple.point(3, -2, 5)
      p2 = Raytracer::Tuple.point(-2, 3, 1)
      expect_raises(ArgumentError) do
        p1 + p2
      end
    end
  end

  describe "#-" do
    it "can subtract 2 points" do
      p1 = Raytracer::Tuple.point(3, 2, 1)
      p2 = Raytracer::Tuple.point(5, 6, 7)
      v = p1 - p2
      v.should eq Raytracer::Tuple.vector(-2, -4, -6)
    end

    it "can subtract a vector from a point" do
      p = Raytracer::Tuple.point(3, 2, 1)
      v = Raytracer::Tuple.vector(5, 6, 7)
      p2 = p - v
      p2.should eq Raytracer::Tuple.point(-2, -4, -6)
    end

    it "can subtract 2 vectors" do
      v1 = Raytracer::Tuple.vector(3, 2, 1)
      v2 = Raytracer::Tuple.vector(5, 6, 7)
      v3 = v1 - v2
      v3.should eq Raytracer::Tuple.vector(-2, -4, -6)
    end

    pending "cannot subtract a point from a vector" do
      v = Raytracer::Tuple.vector(3, 2, 1)
      p = Raytracer::Tuple.point(5, 6, 7)
      expect_raises(ArgumentError) do
        v - p
      end
    end

    it "can subtract a vector from the zero vector" do
      zero = Raytracer::Tuple.vector(0, 0, 0)
      v = Raytracer::Tuple.vector(1, -2, 3)
      v2 = zero - v
      v2.should eq Raytracer::Tuple.vector(-1, 2, -3)
    end
  end

  describe "#- (unary)" do
    it "negates a vector" do
      v = Raytracer::Tuple.vector(1, -2, 3)
      v2 = -v
      v2.should eq Raytracer::Tuple.vector(-1, 2, -3)
    end

    pending "cannot negate a point" do
      p = Raytracer::Tuple.point(1, -2, 3)
      expect_raises(ArgumentError) do
        -p
      end
    end
  end

  describe "#*" do
    it "with a scalar" do
      t = Raytracer::Tuple.new(1, -2, 3, -4)
      t2 = t * 3.5
      t2.should eq Raytracer::Tuple.new(3.5, -7, 10.5, -14)
    end

    it "with a fraction" do
      t = Raytracer::Tuple.new(1, -2, 3, -4)
      t2 = t * 0.5
      t2.should eq Raytracer::Tuple.new(0.5, -1, 1.5, -2)
    end
  end

  describe "/*" do
    it "with a scalar" do
      t = Raytracer::Tuple.new(1, -2, 3, -4)
      t2 = t / 2
      t2.should eq Raytracer::Tuple.new(0.5, -1, 1.5, -2)
    end
  end

  describe "#magnitude" do
    it "takes the magnitude" do
      v = Raytracer::Tuple.vector(1, 0, 0)
      v.magnitude.should eq 1

      v = Raytracer::Tuple.vector(0, 1, 0)
      v.magnitude.should eq 1

      v = Raytracer::Tuple.vector(0, 0, 1)
      v.magnitude.should eq 1

      v = Raytracer::Tuple.vector(1, 2, 3)
      v.magnitude.should eq Math.sqrt(14)

      v = Raytracer::Tuple.vector(-1, -2, -3)
      v.magnitude.should eq Math.sqrt(14)
    end
  end
end
