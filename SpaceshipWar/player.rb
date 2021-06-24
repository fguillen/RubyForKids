# The Player class
class Player
  include Moveable

  attr_reader :x, :y, :state

  def initialize(x, y)
    @image = Gosu::Image.new("#{__dir__}/images/playerShip1_red.png")
    @x = x
    @y = y
    @velocity = Configuration::PLAYER_VELOCITY
    @state = "alive"

    @engine = Engine.new(self)
  end

  def draw
    if is_alive?
      @image.draw_rot(@x, @y, Configuration::Z_PLAYER)
      @engine.draw
    end
  end

  def update
    move
    @engine.update
  end

  def shoot
    Bullet.new(@x, @y - 40, Configuration::PLAYER_BULLET_IMAGE, Configuration::PLAYER_BULLET_VELOCITY, Bullet::KINDS[:player])
    LaserFlash.new(@x, @y - 40)
  end

  def destroy
    @state = "dead"
  end

  def is_alive?
    @state == "alive"
  end
end
