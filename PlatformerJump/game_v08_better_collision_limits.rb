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

    @previous_x = @x
    @previous_y = @y

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

    if(!@grounded)
      affects_gravity()
    end

    @y = @y + @vertical_velocity
    check_collision_with_platforms()

    check_screen_borders()
    check_collision_with_platforms()
  end

  def affects_gravity
    @vertical_velocity = @vertical_velocity + @gravity_force
  end

  def draw
    @image.draw(@x, @y, 0)
  end

  def move_left
    puts "move_left"
    @x = @x - @horizontal_velocity
    check_collision_with_platforms()
  end

  def move_right
    @x = @x + @horizontal_velocity
    check_collision_with_platforms()
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

    @previous_x = @x
    @previous_y = @y
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
    num_steps = 5;
    distance_x = @previous_x - @x
    distance_y = @previous_y - @y
    step_x = distance_x / num_steps.to_f
    step_y = distance_y / num_steps.to_f

    # puts "collision_with_platform: x: #{@x}, previous_x: #{@previous_x}, distance_x: #{distance_x}, step_x: #{step_x}"
    # puts "collision_with_platform: y: #{@y}, previous_y: #{@previous_y}, distance_y: #{distance_y}, step_y: #{step_y}"

    num_steps.times do |i|
      @x = @x + step_x
      @y = @y + step_y

      break if !collision_with_platform?(platform)
    end

    # puts "collision_with_platform: final_x: #{@x}"
    # puts "collision_with_platform: final_y: #{@y}"

    # if the platform is on the bottom
    if (@y < platform.y)
      grounded()
    end

    # if the platform is on the top
    if (@y > platform.y)
      smash_on_top()
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
    if(@x + @width > WIDTH)
      @x = WIDTH - @width
    elsif(@x < 0)
      @x = 0
    end
  end
end


game = Game.new
game.show
