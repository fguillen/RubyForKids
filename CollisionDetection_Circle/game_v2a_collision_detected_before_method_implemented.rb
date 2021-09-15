require "gosu"

class Game < Gosu::Window
  WIDTH = 800
  HEIGHT = 400

  def initialize
    super WIDTH, HEIGHT

    # initialize circles
    @circle_1 = MovingCircle.new
    @circle_2 = MovingCircle.new
  end

  def update
    # update circles
    @circle_1.update
    @circle_2.update

    # check for collision
    if is_there_collision?
      @circle_1.collision
      @circle_2.collision
    else
      @circle_1.no_collision
      @circle_2.no_collision
    end
  end

  def draw
    # draw circles
    @circle_1.draw
    @circle_2.draw
  end

  def is_there_collision?
    # TODO: this method is not implemented
    return false
  end
end

class MovingCircle
  attr_reader :x, :y, :radius

  def initialize
    # initialize Circle with some random values
    @x = rand(100..700)
    @y = 130
    @velocity = rand(-10.0..10.0)
    @color = Gosu::Color.new(255, rand(0..255), rand(0..255), rand(0..255))
    @image = Gosu::Image.new("#{__dir__}/circle.png")
    @radius = @image.width / 2.0
  end

  def collision
    @collision = true
  end

  def no_collision
    @collision = false
  end

  def update
    @x += @velocity

    # invert velocity if circle touches borders of the screen
    if (
      (@x + (@radius * 2) > 800) ||
      (@x < 0)
    )
      @velocity = -@velocity
    end
  end

  def draw
    tmp_color = @color

    # user red Color if @collision is true
    if @collision
      tmp_color = Gosu::Color::RED
    end

    @image.draw(@x, @y, 0, 1, 1, tmp_color)
  end
end

game = Game.new
game.show
