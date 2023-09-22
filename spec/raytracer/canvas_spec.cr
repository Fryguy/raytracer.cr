describe Raytracer::Canvas do
  describe ".new" do
    it "creates a canvas that is initialized to black" do
      c = Raytracer::Canvas.new(10, 20)
      c.width.should eq 10
      c.height.should eq 20

      black = Raytracer::Color.new(0, 0, 0)
      c.canvas.size.should eq 200
      c.canvas.each { |p| p.should eq black }
    end
  end

  describe "#write_pixel / #pixel_at" do
    it "writes a pixel color and reads it back out" do
      c = Raytracer::Canvas.new(10, 20)
      red = Raytracer::Color.new(1, 0, 0)
      c.write_pixel(2, 3, red)
      c.pixel_at(2, 3).should eq red
    end

    it "raises on out of bounds writes/reads" do
      c = Raytracer::Canvas.new(10, 20)
      red = Raytracer::Color.new(1, 0, 0)
      expect_raises(IndexError) { c.write_pixel(-1, 0, red) }
      expect_raises(IndexError) { c.write_pixel(10, 0, red) }
      expect_raises(IndexError) { c.write_pixel(0, -1, red) }
      expect_raises(IndexError) { c.write_pixel(0, 20, red) }
      expect_raises(IndexError) { c.pixel_at(-1, 0) }
      expect_raises(IndexError) { c.pixel_at(10, 0) }
      expect_raises(IndexError) { c.pixel_at(0, -1) }
      expect_raises(IndexError) { c.pixel_at(0, 20) }
    end
  end
end
