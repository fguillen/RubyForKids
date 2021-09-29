require "gosu"

WIDTH = 600
HEIGHT = 400


class Game < Gosu::Window
  def initialize
    super(WIDTH, HEIGHT)
    @images = Gosu::Image.load_tiles("#{__dir__}/assets/Food.png", 16, 16, { retro: true })
  end

  def draw
    @images.each.with_index do |image, index|
      image.draw(index * 64, 0, 0, 4, 4)
    end
  end
end

game = Game.new
game.show
