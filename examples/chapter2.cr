require "../src/raytracer"
require "option_parser"
require "file_utils"

outfile = File.join(__DIR__, "chapter2.ppm")
velocity_multiplier = 11.25

OptionParser.parse do |parser|
  parser.on("-v", "--velocity <value>", "Velocity multiplier") { |v| velocity_multiplier = v.to_f }
  parser.on("-o", "--output <file>", "Output file") { |f| outfile = File.expand_path(f) }
  parser.separator
  parser.on("-h", "--help", "Show this help") do
    puts parser
    exit
  end
  parser.invalid_option do |flag|
    STDERR.puts "ERROR: #{flag} is not a valid option."
    STDERR.puts parser
    exit 1
  end
end

record Projectile, position : Raytracer::Tuple, velocity : Raytracer::Tuple
record Environment, gravity : Raytracer::Tuple, wind : Raytracer::Tuple

def tick(env, proj)
  position = proj.position + proj.velocity
  velocity = proj.velocity + env.gravity + env.wind
  Projectile.new(position, velocity)
end

start = Raytracer::Tuple.point(0, 1, 0)
velocity = Raytracer::Tuple.vector(1, 1.8, 0).normalize * velocity_multiplier
p = Projectile.new(start, velocity)

gravity = Raytracer::Tuple.vector(0, -0.1, 0)
wind = Raytracer::Tuple.vector(-0.01, 0, 0)
e = Environment.new(gravity, wind)

width = 900
height = 550
c = Raytracer::Canvas.new(width, height)
red = Raytracer::Color.new(1, 0, 0)

while p.position.y >= 0 && p.position.x <= width # End when it hits the bottom or goes off the right
  x = p.position.x.round.to_i
  y = p.position.y.round.to_i
  c[x, height - y] = red if 0 <= x < width && 0 <= y < height # Don't draw outside of the canvas
  p = tick(e, p)
end

puts "Writing #{outfile}"
FileUtils.mkdir_p(File.dirname(outfile))
File.write(outfile, c.to_ppm)
