require "gosu"

WIDTH = 800
HEIGHT = 800
NUM_PLATFORMS = 20

class Game < Gosu::Window
  def initialize
    super WIDTH, HEIGHT

    @platforms = create_platforms
    @player = Player.new(@platforms)
  end

  def create_platforms
    platforms = []

    NUM_PLATFORMS.times do
      platform = Platform.new
      platforms.push(platform)
    end

    return platforms
  end

  def update
    keys_control
    @player.update
  end

  def draw
    @platforms.each do |platform|
      platform.draw
    end

    @player.draw
  end

  # Keys control
  def keys_control
    if Gosu.button_down? Gosu::KB_LEFT
      @player.move_left
    end

    if Gosu.button_down? Gosu::KB_RIGHT
      @player.move_right
    end
  end
end

class Platform
  attr_accessor :x, :y, :width, :height

  def initialize
    @image = Gosu::Image.new("#{__dir__}/assets/grass.png")
    @x = rand(0..WIDTH)
    @y = rand(0..HEIGHT)
    @width = @image.width
    @height = @image.height
  end

  def draw
    @image.draw(@x, @y, 0)
  end
end

class Player
  attr_accessor :x, :y, :width, :height

  def initialize(platforms)
    @image = Gosu::Image.new("#{__dir__}/assets/player.png")
    @x = rand(0..WIDTH)
    @y = rand(0..HEIGHT)

    @gravity_force = 1
    @horizontal_velocity = 10
    @vertical_velocity = 0

    @width = @image.width
    @height = @image.height

    @grounded = false

    @platforms = platforms
  end

  def update
    @grounded = false

    check_collision_with_platforms()

    if(!@grounded)
      affects_gravity()
    end

    @y = @y + @vertical_velocity

    check_screen_borders()
  end

  def affects_gravity
    @vertical_velocity = @vertical_velocity + @gravity_force
  end

  def draw
    @image.draw(@x, @y, 0)
  end

  def move_left
    @x = @x - @horizontal_velocity
  end

  def move_right
    @x = @x + @horizontal_velocity
  end

  # Collisions
  def check_collision_with_platforms
    @platforms.each do |platform|
      if (collision_with_platform?(platform))
        collision_with_platform(platform)
      end
    end
  end

  def collision_with_platform?(platform)
    if (
      platform.x < (@x + @width) &&
      (platform.x + platform.width) > @x &&
      platform.y < (@y + @height) &&
      platform.y + platform.height > @y
    )
      return true
    else
      return false
    end
  end

  def collision_with_platform(platform)
    # if the platform is on the bottom
    if (@y < platform.y)
      @y = platform.y - @height
      grounded()

      return
    end

    # if the platform is on the top
    if (@y > platform.y)
      @y = platform.y + platform.height

      return
    end

    # if the platform is on the right
    if (@x < platform.x)
      @x = platform.x - @width

      return
    end

    # if the platform is on the left
    if (@x > platform.x)
      @x = platform.x + platform.width

      return
    end
  end

  def grounded()
    @grounded = true
    @vertical_velocity = 0
  end

  def check_screen_borders
    if(@x > WIDTH)
      @x = 0
    elsif(@x + @width < 0)
      @x = WIDTH
    end

    if(@y > HEIGHT)
      @y = 0
    elsif(@y + @height < 0)
      @y = HEIGHT
    end
  end
end


game = Game.new
game.show
