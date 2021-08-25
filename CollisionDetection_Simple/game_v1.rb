require "gosu"

class Game < Gosu::Window
  WIDTH = 800
  HEIGHT = 800

  def initialize
    super WIDTH, HEIGHT
    @box_1 = MovingBox.new
    @box_2 = MovingBox.new
  end

  def update
    @box_1.update
    @box_2.update
  end

  def draw
    @box_1.draw
    @box_2.draw
  end
end

class MovingBox
  def initialize
    @x = rand(100..700)
    @y = 100
    @velocity = rand(-10.0..10.0)
    @width = 50
    @height = 50
    @color = Gosu::Color.new(255, rand(0..255), rand(0..255), rand(0..255))
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
    Gosu.draw_rect(@x, @y, @width, @height, @color)
  end
end


game = Game.new
game.show
