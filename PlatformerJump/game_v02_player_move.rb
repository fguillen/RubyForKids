require "gosu"

WIDTH = 800
HEIGHT = 800
NUM_PLATFORMS = 10

class Game < Gosu::Window
  def initialize
    super WIDTH, HEIGHT

    @platforms = create_platforms
    @player = Player.new
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
  def initialize
    @image = Gosu::Image.new("#{__dir__}/assets/grass.png")
    @x = rand(0..WIDTH)
    @y = rand(0..HEIGHT)
  end

  def draw
    @image.draw(@x, @y, 0)
  end
end

class Player
  def initialize
    @image = Gosu::Image.new("#{__dir__}/assets/player.png")
    @x = rand(0..WIDTH)
    @y = rand(0..HEIGHT)
    @velocity = 10
  end

  def draw
    @image.draw(@x, @y, 0)
  end

  def move_left
    @x = @x - @velocity
  end

  def move_right
    @x = @x + @velocity
  end
end


game = Game.new
game.show
