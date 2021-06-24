# We import the "gosu" library
require "gosu"

# The Bee class
class Bee
  def initialize
    @image = Gosu::Image.new("images/bee.png");
    @x = 600
    @y = 50
    @width = 200
    @height = 153
    @velocity = 10
  end

  def update
    move
  end

  def draw
    @image.draw(@x, @y, 2)
    # debug
  end

  # The debug method to see the box
  def debug
    Gosu.draw_rect(@x, @y, @width, @height, Gosu::Color::YELLOW, 0)
  end


  # These methods are to make instance variables accessible
  # for another instances like the Person instance
  def x
    return @x
  end

  def y
    return @y
  end

  def width
    return @width
  end

  def height
    return @height
  end


  # This is the same logic we have implemented in other
  # games, nothing new here
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

class Person
  def initialize(bee)
    @image_happy = Gosu::Image.new("images/person_happy.png");
    @image_unhappy = Gosu::Image.new("images/person_unhappy.png");
    @x = 150
    @y = 200
    @width = 228
    @height = 524
    @bee = bee
    @status = "happy"
  end

  def update
    if(collision_with_bee)
      @status = "unhappy"
    else
      @status = "happy"
    end
  end

  def draw
    if(@status == "happy")
      @image_happy.draw(@x, @y, 1)
    else
      @image_unhappy.draw(@x, @y, 1)
    end

    # debug
  end

  # The debug method to see the box
  def debug
    Gosu.draw_rect(@x, @y, @width, @height, Gosu::Color::YELLOW, 0)
  end

  # This is the core of the algorithm
  # I took this implementation from here:
  # https://developer.mozilla.org/en-US/docs/Games/Techniques/2D_collision_detection
  def collision_with_bee
    if(
      @bee.x < (@x + @width) &&
      (@bee.x + @bee.width) > @x &&
      @bee.y < (@y + @height) &&
      @bee.y + @bee.height > @y
    )
       return true
    else
      return false
    end
  end
end

# This is the main class the Game class
class Game < Gosu::Window
  def initialize
    super 1000, 800 # the size of the Window

    @bee = Bee.new # our "bee" instance
    @person = Person.new(@bee) # notice that I pass the "bee" instance to the "person" instance in the constructor
  end

  def update
    @bee.update
    @person.update
  end

  def draw
    @bee.draw
    @person.draw
  end
end

Game.new.show
