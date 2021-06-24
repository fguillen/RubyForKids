class LaserFlash
  @all = []

  class << self
    attr_accessor :all
  end

  def initialize(x, y)
    @animation = [Gosu::Image.new("#{__dir__}/images/laserBlue10.png"), Gosu::Image.new("#{__dir__}/images/laserBlue11.png")]
    @x = x
    @y = y
    @animation_frame = -1
    next_frame

    LaserFlash.all.push(self)
  end

  def update
    next_frame if Gosu.milliseconds >= @animation_next_frame_at
  end

  def next_frame
    @animation_frame += 1
    @animation_next_frame_at = Gosu.milliseconds + 10

    if @animation_frame >= @animation.length
      die
    else
      @image = @animation[@animation_frame]
    end
  end

  def die
    LaserFlash.all.delete(self)
  end

  def draw
    @image.draw_rot(@x, @y, Configuration::Z_EXPLOSION)
  end
end
