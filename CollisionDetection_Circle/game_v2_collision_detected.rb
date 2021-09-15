require "gosu"

class Game < Gosu::Window
  WIDTH = 800
  HEIGHT = 800

  def initialize
    super WIDTH, HEIGHT
    @circle_1 = MovingCircle.new
    @circle_2 = MovingCircle.new
  end

  def update
    @circle_1.update
    @circle_2.update

    if is_there_collision?
      @circle_1.collision
      @circle_2.collision
    else
      @circle_1.no_collision
      @circle_2.no_collision
    end
  end

  def draw
    @circle_1.draw
    @circle_2.draw
  end

  # from here: https://en.wikipedia.org/wiki/Euclidean_distance
  def distance(x1, y1, x2, y2)
    result =
      Math.sqrt(
        ((x2 - x1) ** 2) +
        ((y2 - y1) ** 2)
      )

    return result
  end

  def is_there_collision?
    return distance(@circle_1.x, @circle_1.y, @circle_2.x, @circle_2.y) < (@circle_1.radius + @circle_2.radius)
  end
end

class MovingCircle
  attr_reader :x, :y, :radius

  def initialize
    @x = rand(100..700)
    @y = 100
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

    if (
      (@x + (@radius * 2) > 800) ||
      (@x < 0)
    )
      @velocity = -@velocity
    end
  end

  def draw
    color = @color

    if @collision
      color = Gosu::Color::RED
    end

    @image.draw(@x, @y, 0, 1, 1, color)
  end
end


game = Game.new
game.show
