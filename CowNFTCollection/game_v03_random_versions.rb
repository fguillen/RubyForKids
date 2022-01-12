require "gosu"

WIDTH = 768
HEIGHT = 768

class Game < Gosu::Window
  def initialize
    super(WIDTH, HEIGHT)
    @heads = []
    @heads.push(Gosu::Image.new("#{__dir__}/assets/head_01.png", { retro: true }))

    @bodies = []
    @bodies.push(Gosu::Image.new("#{__dir__}/assets/body_01.png", { retro: true }))

    @mouths = []
    @mouths.push(Gosu::Image.new("#{__dir__}/assets/mouth_01.png", { retro: true }))
    @mouths.push(Gosu::Image.new("#{__dir__}/assets/mouth_02.png", { retro: true }))

    @ears = []
    @ears.push(Gosu::Image.new("#{__dir__}/assets/ears_01.png", { retro: true }))

    @eyes = []
    @eyes.push(Gosu::Image.new("#{__dir__}/assets/eyes_01.png", { retro: true }))
    @eyes.push(Gosu::Image.new("#{__dir__}/assets/eyes_02.png", { retro: true }))
    @eyes.push(Gosu::Image.new("#{__dir__}/assets/eyes_03.png", { retro: true }))

    @feet = []
    @feet.push(Gosu::Image.new("#{__dir__}/assets/feet_01.png", { retro: true }))
    @feet.push(Gosu::Image.new("#{__dir__}/assets/feet_02.png", { retro: true }))

    random_cow()
  end

  def random_cow
    @head_actual = @heads.sample
    @body_actual = @bodies.sample
    @mouth_actual = @mouths.sample
    @ears_actual = @ears.sample
    @eyes_actual = @eyes.sample
    @feet_actual = @feet.sample
  end

  def draw
    Gosu.draw_rect(0, 0, WIDTH, HEIGHT, Gosu::Color::WHITE)
    @head_actual.draw(0, 0, 0, 24, 24)
    @body_actual.draw(0, 0, 0, 24, 24)
    @mouth_actual.draw(0, 0, 0, 24, 24)
    @ears_actual.draw(0, 0, 0, 24, 24)
    @eyes_actual.draw(0, 0, 0, 24, 24)
    @feet_actual.draw(0, 0, 0, 24, 24)
  end

  def button_down(id)
    if id == Gosu::MsLeft
      random_cow()
    end
  end
end

game = Game.new
game.show
