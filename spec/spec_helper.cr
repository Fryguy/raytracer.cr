require "spec"
require "../src/raytracer"

def with_ppm_tempfile
  t = File.tempname("out", ".ppm")
  yield t
ensure
  File.delete?(t) if t
end

def run_example(*args)
  with_ppm_tempfile do |t|
    args = args.to_a + ["--output", t]
    status = Process.run("crystal", args)
    status.success?.should be_true
    File.exists?(t) ? File.read(t) : ""
  end
end
