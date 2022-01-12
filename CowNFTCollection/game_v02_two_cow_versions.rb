require "gosu"

WIDTH = 768
HEIGHT = 768

class Game < Gosu::Window
  def initialize
    super(WIDTH, HEIGHT)
    @head_01 = Gosu::Image.new("#{__dir__}/assets/head_01.png", { retro: true })
    @body_01 = Gosu::Image.new("#{__dir__}/assets/body_01.png", { retro: true })
    @mouth_01 = Gosu::Image.new("#{__dir__}/assets/mouth_01.png", { retro: true })
    @mouth_02 = Gosu::Image.new("#{__dir__}/assets/mouth_02.png", { retro: true })
    @ears_01 = Gosu::Image.new("#{__dir__}/assets/ears_01.png", { retro: true })
    @eyes_01 = Gosu::Image.new("#{__dir__}/assets/eyes_01.png", { retro: true })
    @eyes_02 = Gosu::Image.new("#{__dir__}/assets/eyes_02.png", { retro: true })
    @feet_01 = Gosu::Image.new("#{__dir__}/assets/feet_01.png", { retro: true })
    @feet_02 = Gosu::Image.new("#{__dir__}/assets/feet_02.png", { retro: true })

    @version = 1
  end

  def draw
    Gosu.draw_rect(0, 0, WIDTH, HEIGHT, Gosu::Color::WHITE)

    if @version == 1
      @head_01.draw(0, 0, 0, 24, 24)
      @body_01.draw(0, 0, 0, 24, 24)
      @mouth_01.draw(0, 0, 0, 24, 24)
      @ears_01.draw(0, 0, 0, 24, 24)
      @eyes_01.draw(0, 0, 0, 24, 24)
      @feet_01.draw(0, 0, 0, 24, 24)
    else
      @head_01.draw(0, 0, 0, 24, 24)
      @body_01.draw(0, 0, 0, 24, 24)
      @mouth_02.draw(0, 0, 0, 24, 24)
      @ears_01.draw(0, 0, 0, 24, 24)
      @eyes_02.draw(0, 0, 0, 24, 24)
      @feet_02.draw(0, 0, 0, 24, 24)
    end
  end

  def button_down(id)
    if id == Gosu::MsLeft
      if @version == 1
        @version = 2
      else
        @version = 1
      end
    end
  end
end

game = Game.new
game.show
