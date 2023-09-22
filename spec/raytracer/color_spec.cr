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
end
