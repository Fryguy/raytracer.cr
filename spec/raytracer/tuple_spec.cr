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
end
