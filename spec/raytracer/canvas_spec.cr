require "../spec_helper"

describe Raytracer::Canvas do
  describe ".new" do
    it "creates a canvas that is initialized to black by default" do
      c = Raytracer::Canvas.new(10, 20)
      c.width.should eq 10
      c.height.should eq 20

      black = Raytracer::Color.new(0, 0, 0)
      c.canvas.size.should eq 200
      c.canvas.each { |p| p.should eq black }
    end

    it "creates a canvas that is initialized to a color" do
      red = Raytracer::Color.new(1, 0, 0)
      c = Raytracer::Canvas.new(10, 20, red)

      c.canvas.each { |p| p.should eq red }
    end
  end

  describe "#[]= / #[]" do
    it "writes a pixel color and reads it back out" do
      c = Raytracer::Canvas.new(10, 20)
      red = Raytracer::Color.new(1, 0, 0)
      c[2, 3] = red
      c[2, 3].should eq red
    end

    it "raises on out of bounds writes/reads" do
      c = Raytracer::Canvas.new(10, 20)
      red = Raytracer::Color.new(1, 0, 0)
      expect_raises(IndexError) { c[-1, 0] = red }
      expect_raises(IndexError) { c[10, 0] = red }
      expect_raises(IndexError) { c[0, -1] = red }
      expect_raises(IndexError) { c[0, 20] = red }
      expect_raises(IndexError) { c[-1, 0] }
      expect_raises(IndexError) { c[10, 0] }
      expect_raises(IndexError) { c[0, -1] }
      expect_raises(IndexError) { c[0, 20] }
    end
  end

  describe "#to_ppm" do
    it "has a valid header" do
      c = Raytracer::Canvas.new(5, 3)

      ppm = c.to_ppm
      ppm.lines[0..2].join("\n").should eq <<-PPM
        P3
        5 3
        255
        PPM
    end

    it "has the pixel data" do
      c = Raytracer::Canvas.new(5, 3)
      c[0, 0] = Raytracer::Color.new(1.5, 0, 0)
      c[2, 1] = Raytracer::Color.new(0, 0.5, 0)
      c[4, 2] = Raytracer::Color.new(-0.5, 0, 1)

      ppm = c.to_ppm
      ppm.lines[3..5].join("\n").should eq <<-PPM
        255 0 0 0 0 0 0 0 0 0 0 0 0 0 0
        0 0 0 0 0 0 0 128 0 0 0 0 0 0 0
        0 0 0 0 0 0 0 0 0 0 0 0 0 0 255
        PPM
    end

    it "splits long lines" do
      c1 = Raytracer::Color.new(1, 0.8, 0.6)
      c = Raytracer::Canvas.new(10, 2, c1)

      ppm = c.to_ppm
      ppm.lines[3..6].join("\n").should eq <<-PPM
        255 204 153 255 204 153 255 204 153 255 204 153 255 204 153 255 204
        153 255 204 153 255 204 153 255 204 153 255 204 153
        255 204 153 255 204 153 255 204 153 255 204 153 255 204 153 255 204
        153 255 204 153 255 204 153 255 204 153 255 204 153
        PPM
    end

    it "ends with a newline character" do
      c = Raytracer::Canvas.new(5, 3)

      ppm = c.to_ppm
      ppm[-1].should eq '\n'
    end
  end
end
