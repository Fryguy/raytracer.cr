describe "examples/chapter2", tags: "ex" do
  it "works" do
    ppm = run_example("examples/chapter2.cr")
    ppm.should eq File.read(File.join(__DIR__, "data/chapter2.ppm"))
  end

  it "handles projectiles going outside the canvas" do
    ppm = run_example("examples/chapter2.cr", "--velocity", "12.25")
    ppm.should eq File.read(File.join(__DIR__, "data/chapter2_oob.ppm"))
  end
end
