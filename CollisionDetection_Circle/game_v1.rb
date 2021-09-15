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
  end

  def draw
    @circle_1.draw
    @circle_2.draw
  end
end

class MovingCircle
  def initialize
    @x = rand(100..700)
    @y = 100
    @velocity = rand(-10.0..10.0)
    @color = Gosu::Color.new(255, rand(0..255), rand(0..255), rand(0..255))
    @image = Gosu::Image.new("#{__dir__}/circle.png")
    @radius = @image.width / 2.0
  end

  def update
    @x += @velocity

    if (
      (@x + @width > 800) ||
      (@x < 0)
    )
      @velocity = -@velocity
    end
  end

  def draw
    @image.draw(@x, @y, 0, 1, 1, @color)
  end
end


game = Game.new
game.show
