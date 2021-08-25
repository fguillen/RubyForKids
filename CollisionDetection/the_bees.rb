# We import the "gosu" library
require "gosu"

# This is the main class the Game class
class Game < Gosu::Window
  WIDTH = 1000
  HEIGHT = 800

  def initialize
    super WIDTH, HEIGHT # the size of the Window

    @bee = Bee.new # our "bee" instance
    @person = Person.new(@bee) # notice that I pass the "bee" instance to the "person" instance in the constructor
    @font = Gosu::Font.new(20, name: Gosu.default_font_name)
  end

  def update
    @bee.update
    @person.update
  end

  def draw
    draw_background
    @bee.draw
    @person.draw
    draw_instructions
  end

  def draw_background
    # Drawing a background color
    # See the doc of Gosu.draw_rect: https://www.rubydoc.info/github/gosu/gosu/master/Gosu.draw_rect
    # See the doc of Gosu::Color constructor: https://www.rubydoc.info/github/gosu/gosu/master/Gosu%2FColor:initialize
    Gosu.draw_rect(0, 0, WIDTH, HEIGHT, Gosu::Color.new(255, 254, 197, 187), 0)
  end

  def draw_instructions
    # See the documentation for Gosu::Font.draw_text:
    # https://www.rubydoc.info/github/gosu/gosu/master/Gosu%2FFont:draw_text
    @font.draw_text("Use the cursors to move the bee and scare the person", 400, 750, 0, 1, 1, Gosu::Color::BLACK)
  end
end

# The Bee class
class Bee
  def initialize
    @image = Gosu::Image.new("#{__dir__}/images/bee.png");
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
    @image.draw(@x, @y, 20)

    # You can uncomment this line to see the Bee square
    debug
  end

  # The debug method to see the box
  def debug
    Gosu.draw_rect(@x, @y, @width, @height, Gosu::Color::YELLOW, 10)
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
    @image_happy = Gosu::Image.new("#{__dir__}/images/person_happy.png");
    @image_unhappy = Gosu::Image.new("#{__dir__}/images/person_unhappy.png");
    @x = 150
    @y = 200
    @width = 228
    @height = 524
    @bee = bee
    @status = "happy"
  end

  def update
    if collision_with_bee
      @status = "unhappy"
    else
      @status = "happy"
    end
  end

  def draw
    if @status == "happy"
      @image_happy.draw(@x, @y, 15)
    else
      @image_unhappy.draw(@x, @y, 15)
    end

    # You can uncomment this line to see the Person square
    debug
  end

  # The debug method to see the box
  def debug
    Gosu.draw_rect(@x, @y, @width, @height, Gosu::Color::YELLOW, 10)
  end

  # This is the core of the algorithm
  # I took this implementation from here:
  # https://developer.mozilla.org/en-US/docs/Games/Techniques/2D_collision_detection
  def collision_with_bee
    if (
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



# Start the game
Game.new.show
