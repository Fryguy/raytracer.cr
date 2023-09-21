require "../src/raytracer"

record Projectile, position : Raytracer::Tuple, velocity : Raytracer::Tuple
record Environment, gravity : Raytracer::Tuple, wind : Raytracer::Tuple

def tick(env, proj)
  position = proj.position + proj.velocity
  velocity = proj.velocity + env.gravity + env.wind
  Projectile.new(position, velocity)
end

velocity_multiplier = 1
p = Projectile.new(Raytracer::Tuple.point(0, 1, 0), Raytracer::Tuple.vector(1, 1, 0).normalize * velocity_multiplier)
e = Environment.new(Raytracer::Tuple.vector(0, -0.1, 0), Raytracer::Tuple.vector(-0.01, 0, 0))

i = 0
while p.position.y > 0
  p = tick(e, p)
  i += 1
  puts "#{i}:\tx = #{p.position.x.round(3)}\ty = #{p.position.y.round(3)}"
end
