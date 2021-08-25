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

    check_collisions
  end

  def draw
    @box_1.draw
    @box_2.draw
  end

  def check_collisions
    # box_1 with box_2
    if (collision_left?(@box_1, @box_2))
      @box_1.bounce_right
    end

    if (collision_right?(@box_1, @box_2))
      @box_1.bounce_left
    end

    if (collision_up?(@box_1, @box_2))
      @box_1.bounce_down
    end

    if (collision_down?(@box_1, @box_2))
      @box_1.bounce_up
    end

    # box_2 with box_1
    if (collision_left?(@box_2, @box_1))
      @box_2.bounce_right
    end

    if (collision_right?(@box_2, @box_1))
      @box_2.bounce_left
    end

    if (collision_up?(@box_2, @box_1))
      @box_2.bounce_down
    end

    if (collision_down?(@box_2, @box_1))
      @box_2.bounce_up
    end
  end

  # def is_there_collision?
  #   if (
  #     @box_1.x < (@box_2.x + @box_2.width) &&
  #     (@box_1.x + @box_1.width) > @box_2.x &&
  #     @box_1.y < (@box_2.y + @box_2.height) &&
  #     @box_1.y + @box_1.height > @box_2.y
  #   )
  #     return true
  #   else
  #     return false
  #   end
  # end

  def collision_left?(box_a, box_b)
    if (
      (box_b.x < box_a.x) &&
      (box_b.x + box_b.width > box_a.x)
    )
      return true
    else
      return false
    end
  end

  def collision_right?(box_a, box_b)
    if (
      (box_a.x < box_b.x) &&
      (box_a.x + box_a.width > box_b.x)
    )
      return true
    else
      return false
    end
  end

  def collision_down?(box_a, box_b)
    if (
      (box_a.y < box_b.y) &&
      (box_a.y + box_a.width > box_b.y)
    )
      return true
    else
      return false
    end
  end

  def collision_up?(box_a, box_b)
    if (
      (box_a.y < box_b.y) &&
      (box_b.y + box_b.width > box_b.y)
    )
      return true
    else
      return false
    end
  end
end

class MovingBox
  attr_reader :x, :y, :width, :height, :velocity

  def initialize
    @x = rand(100..700)
    @y = 100
    @velocity_x = rand(-10.0..10.0)
    @velocity_y = 0
    @width = 50
    @height = 50
    @color = Gosu::Color.new(255, rand(0..255), rand(0..255), rand(0..255))
    @collision = false
  end

  def bounce_up
    @velocity_y = @velocity_y.abs
  end

  def bounce_down
    @velocity_y = -@velocity_y.abs
  end

  def bounce_right
    @velocity_x = @velocity_x.abs
  end

  def bounce_left
    @velocity_x = -@velocity_x.abs
  end

  def update
    @x += @velocity_x
    @y += @velocity_y

    bounce_on_screen_borders
  end

  def bounce_on_screen_borders
    if (@x + @width > 800)
      bounce_left
    end

    if (@x < 0)
      bounce_right
    end

    if (@y + @height > 800)
      bounce_down
    end

    if (@y < 0)
      bounce_up
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
