class Engine
  def initialize(player)
    @player = player
    @emit_particle_each_seconds = 0.02
    emit_particle
  end

  def update
    if Time.now - @last_particle_emitted_at > @emit_particle_each_seconds
      emit_particle
    end

    EngineParticle.engine_particles.each do |engine_particle|
      engine_particle.update
    end
  end

  def draw
    EngineParticle.engine_particles.each do |engine_particle|
      engine_particle.draw
    end
  end

  def emit_particle
    EngineParticle.new(@player.x, @player.y)
    @last_particle_emitted_at = Time.now
  end
end

class EngineParticle
  @@engine_particles = []

  def initialize(x, y)
    @image = Gosu::Image.new("#{__dir__}/images/engine_particle.png")
    @seconds_to_live = 0.3
    @born_at = Time.now
    @x = x
    @y = y + 20
    @scale = rand(0.1..3.0)
    @angle = rand(-20..20)
    @color = Gosu::Color.new(255, 255, 255, 255)

    @@engine_particles.push(self)
  end

  def update
    alive_time = Time.now - @born_at
    alpha = Easing.ease_out_quint(alive_time, 0, 255, @seconds_to_live)
    @color.alpha = alpha
    @color.blue = alpha

    @y += 5
    @x = @x - 1 + rand(3)

    if alive_time >= @seconds_to_live
      destroy
    end
  end

  def destroy
    @@engine_particles.delete(self)
  end

  def draw
    # draw_rot(x, y, z, angle, center_x = 0.5, center_y = 0.5, scale_x = 1, scale_y = 1, color = 0xff_ffffff, mode = :default)
    @image.draw_rot(@x, @y, Configuration::Z_ENGINE, @angle, 0.5, 0, @scale, @scale, @color)
  end

  def self.engine_particles
    @@engine_particles
  end
end
