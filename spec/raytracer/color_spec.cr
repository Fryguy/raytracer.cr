describe Raytracer::Color do
  describe ".new" do
    it "creates a new color" do
      c = Raytracer::Color.new(-0.5, 0.4, 1.7)
      c.red.should eq -0.5
      c.green.should eq 0.4
      c.blue.should eq 1.7
    end
  end

  describe "#==" do
    it "handles floating points within EPSILON" do
      c = Raytracer::Color.new(0.33333, 0.33333, 0.33333)
      c.should eq Raytracer::Color.new(1.0 / 3.0, 1.0 / 3.0, 1.0 / 3.0)
    end
  end

  describe "#+" do
    it "can add 2 colors" do
      c1 = Raytracer::Color.new(0.9, 0.6, 0.75)
      c2 = Raytracer::Color.new(0.7, 0.1, 0.25)
      c3 = c1 + c2
      c3.should eq Raytracer::Color.new(1.6, 0.7, 1.0)
    end
  end

  describe "#-" do
    it "can subtract 2 colors" do
      c1 = Raytracer::Color.new(0.9, 0.6, 0.75)
      c2 = Raytracer::Color.new(0.7, 0.1, 0.25)
      c3 = c1 - c2
      c3.should eq Raytracer::Color.new(0.2, 0.5, 0.5)
    end
  end

  describe "#*" do
    it "can multiply a color by a scalar" do
      c1 = Raytracer::Color.new(0.2, 0.3, 0.4)
      c2 = c1 * 2
      c2.should eq Raytracer::Color.new(0.4, 0.6, 0.8)
    end

    it "can multiply 2 colors (Hadamard product)" do
      c1 = Raytracer::Color.new(1, 0.2, 0.4)
      c2 = Raytracer::Color.new(0.9, 1, 0.1)
      c3 = c1 * c2
      c3.should eq Raytracer::Color.new(0.9, 0.2, 0.04)
    end
  end

  describe "#to_rgb" do
    it "returns rgb values in the 0-255 range" do
      c = Raytracer::Color.new(0, 0.5, 1)
      c.to_rgb.should eq({0, 128, 255})
    end

    it "clamps values outside of the 0-255 range" do
      c = Raytracer::Color.new(-0.5, 0.5, 1.5)
      c.to_rgb.should eq({0, 128, 255})
    end
  end
end
