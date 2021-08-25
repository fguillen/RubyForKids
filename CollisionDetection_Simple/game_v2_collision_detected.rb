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

    if is_there_collision?
      @box_1.collision
      @box_2.collision
    else
      @box_1.no_collision
      @box_2.no_collision
    end
  end

  def draw
    @box_1.draw
    @box_2.draw
  end

  def is_there_collision?
    if (
      @box_1.x < (@box_2.x + @box_2.width) &&
      (@box_1.x + @box_1.width) > @box_2.x &&
      @box_1.y < (@box_2.y + @box_2.height) &&
      @box_1.y + @box_1.height > @box_2.y
    )
      return true
    else
      return false
    end
  end
end

class MovingBox
  attr_reader :x, :y, :width, :height

  def initialize
    @x = rand(100..700)
    @y = 100
    @velocity = rand(-10.0..10.0)
    @width = 50
    @height = 50
    @color = Gosu::Color.new(255, rand(0..255), rand(0..255), rand(0..255))
    @collision = false
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
      (@x + @width > 800) ||
      (@x < 0)
    )
      @velocity = -@velocity
    end
  end

  def draw
    if @collision
      Gosu.draw_rect(@x, @y, @width, @height, Gosu::Color::RED)
    else
      Gosu.draw_rect(@x, @y, @width, @height, @color)
    end
  end
end


game = Game.new
game.show
