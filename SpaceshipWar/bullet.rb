# The Bullet class
class Bullet
  @all = []

  class << self
    attr_reader :all
  end

  attr_reader :x, :y, :kind

  KINDS = {
    player: 1,
    enemy: 2
  }

  def initialize(x, y, image, velocity, kind)
    @image = image
    @x = x
    @y = y
    @velocity = velocity
    @kind = kind

    Bullet.all.push(self)
  end

  def update
    @y += @velocity
  end

  def draw
    @image.draw_rot(@x, @y, Configuration::Z_BULLET)
  end

  def destroy
    Bullet.all.delete(self)
  end
end
