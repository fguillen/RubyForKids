require "gosu"
WIDTH = 800
HEIGHT = 800
NUM_BOXES = 200
BOX_DIMENSION = 10
BOX_VELOCITY = 5.0

class Game < Gosu::Window
  def initialize
    super WIDTH, HEIGHT
    @boxes = []

    NUM_BOXES.times do
      box = MovingBox.new
      @boxes.push(box)
    end
  end

  def update
    @boxes.each do |box|
      box.update
    end

    check_collisions
  end

  def draw
    @boxes.each do |box|
      box.draw
    end
  end

  def check_collisions
    @boxes.each do |box_a|
      @boxes.each do |box_b|
        if is_there_collision?(box_a, box_b)
          if collision_left?(box_a, box_b)
            box_a.bounce_right
          end

          if collision_right?(box_a, box_b)
            box_a.bounce_left
          end

          if collision_up?(box_a, box_b)
            box_a.bounce_down
          end

          if collision_down?(box_a, box_b)
            box_a.bounce_up
          end
        end
      end
    end
  end

  def is_there_collision?(box_a, box_b)
    if (
      box_a.x < (box_b.x + box_b.width) &&
      (box_a.x + box_a.width) > box_b.x &&
      box_a.y < (box_b.y + box_b.height) &&
      box_a.y + box_a.height > box_b.y
    )
      return true
    else
      return false
    end
  end

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
      (box_a.y > box_b.y) &&
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
    @y = rand(100..700)
    @velocity_x = rand(-BOX_VELOCITY..BOX_VELOCITY)
    @velocity_y = rand(-BOX_VELOCITY..BOX_VELOCITY)
    @width = BOX_DIMENSION
    @height = BOX_DIMENSION
    @color = Gosu::Color.new(255, rand(0..255), rand(0..255), rand(0..255))
  end

  def bounce_up
    @velocity_y = -@velocity_y.abs
  end

  def bounce_down
    @velocity_y = @velocity_y.abs
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
      bounce_up
    end

    if (@y < 0)
      bounce_down
    end
  end

  def draw
    Gosu.draw_rect(@x, @y, @width, @height, @color)
  end
end

game = Game.new
game.show
