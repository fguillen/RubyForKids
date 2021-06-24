class Explosion
  @all = []

  class << self
    attr_accessor :all
  end

  def initialize(x, y)
    @animation = [Gosu::Image.new("#{__dir__}/images/laserBlue08.png"), Gosu::Image.new("#{__dir__}/images/laserBlue09.png")]
    @x = x
    @y = y
    @animation_frame = -1
    next_frame

    Explosion.all.push(self)
  end

  def update
    next_frame if Gosu.milliseconds >= @animation_next_frame_at
  end

  def next_frame
    @animation_frame += 1
    @animation_next_frame_at = Gosu.milliseconds + 100

    if @animation_frame >= @animation.length
      die
    else
      @image = @animation[@animation_frame]
    end
  end

  def die
    Explosion.all.delete(self)
  end

  def draw
    @image.draw_rot(@x, @y, Configuration::Z_EXPLOSION)
  end
end