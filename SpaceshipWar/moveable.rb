module Moveable
  def move
    move_left if Gosu.button_down? Gosu::KB_LEFT
    move_right if Gosu.button_down? Gosu::KB_RIGHT
    move_up if Gosu.button_down? Gosu::KB_UP
    move_down if Gosu.button_down? Gosu::KB_DOWN
  end

  def move_left
    @x -= @velocity
  end

  def move_right
    @x += @velocity
  end

  def move_up
    @y -= @velocity
  end

  def move_down
    @y += @velocity
  end
end
