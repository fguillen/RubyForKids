require "gosu"

WIDTH = 800
HEIGHT = 800
NUM_PLATFORMS = 10

class Game < Gosu::Window
  def initialize
    super WIDTH, HEIGHT

    @platforms = []
    create_platforms
  end

  def create_platforms
    NUM_PLATFORMS.times do
      platform = Platform.new
      @platforms.push(platform)
    end
  end

  def update
    # nothing here yet
  end

  def draw
    @platforms.each do |platform|
      platform.draw
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


game = Game.new
game.show
