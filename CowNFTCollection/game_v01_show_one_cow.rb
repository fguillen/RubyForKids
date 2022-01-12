require "gosu"

WIDTH = 800
HEIGHT = 800

class Game < Gosu::Window
  def initialize
    super(WIDTH, HEIGHT)
    @head_01 = Gosu::Image.new("#{__dir__}/assets/head_01.png", { retro: true })
    @body_01 = Gosu::Image.new("#{__dir__}/assets/body_01.png", { retro: true })
    @mouth_01 = Gosu::Image.new("#{__dir__}/assets/mouth_01.png", { retro: true })
    @ears_01 = Gosu::Image.new("#{__dir__}/assets/ears_01.png", { retro: true })
    @eyes_01 = Gosu::Image.new("#{__dir__}/assets/eyes_01.png", { retro: true })
    @feet_01 = Gosu::Image.new("#{__dir__}/assets/feet_01.png", { retro: true })
  end

  def draw
    Gosu.draw_rect(0, 0, WIDTH, HEIGHT, Gosu::Color::WHITE)
    @head_01.draw(0, 0, 0, 24, 24)
    @body_01.draw(0, 0, 0, 24, 24)
    @mouth_01.draw(0, 0, 0, 24, 24)
    @ears_01.draw(0, 0, 0, 24, 24)
    @eyes_01.draw(0, 0, 0, 24, 24)
    @feet_01.draw(0, 0, 0, 24, 24)
  end
end

game = Game.new
game.show
