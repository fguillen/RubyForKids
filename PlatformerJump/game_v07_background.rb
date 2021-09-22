require "gosu"

WIDTH = 1540
HEIGHT = 960
NUM_PLATFORMS = 20

class Game < Gosu::Window
  def initialize
    super WIDTH, HEIGHT

    @map = File.read("#{__dir__}/assets/map.txt")
    @platforms = create_platforms(@map)
    @player = Player.new(@platforms)

    @background = Gosu::Image.new("#{__dir__}/assets/background.png")
  end

  def create_platforms(map)
    puts map

    platforms = []
    map.split.each_with_index do |line_data, line_index|
      line_data.each_char.with_index do |char, column_index|
        puts "char: #{char}, column_index: #{column_index}"

        if(char == "X")
          platform = Platform.new(line_index, column_index)
          platforms.push(platform)
        end
      end
    end

    return platforms
  end

  def update
    keys_control
    @player.update
  end

  def draw
    @background.draw(0, 0, 0)

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

    if Gosu.button_down? Gosu::KB_SPACE
      @player.jump
    end
  end
end

class Platform
  attr_accessor :x, :y, :width, :height

  def initialize(line_index, column_index)
    @image = Gosu::Image.new("#{__dir__}/assets/grass.png")
    @width = @image.width
    @height = @image.height

    @x = column_index * width
    @y = line_index * height
  end

  def draw
    @image.draw(@x, @y, 0)
  end
end

class Player
  attr_accessor :x, :y, :width, :height

  def initialize(platforms)
    @image = Gosu::Image.new("#{__dir__}/assets/player.png")
    @x = WIDTH / 2
    @y = HEIGHT / 2

    @gravity_force = 1
    @jump_force = 20
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

  def jump
    if(@grounded)
      @vertical_velocity = @vertical_velocity - @jump_force
    end
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
      smash_on_top()

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

  def smash_on_top()
    if(@vertical_velocity < 0)
      @vertical_velocity = 0
    end
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
