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

    @colors = []
    @colors.push(Gosu::Color.rgba(255, 173, 173, 255))
    @colors.push(Gosu::Color.rgba(255, 214, 165, 255))
    @colors.push(Gosu::Color.rgba(253, 255, 182, 255))
    @colors.push(Gosu::Color.rgba(202, 255, 191, 255))
    @colors.push(Gosu::Color.rgba(155, 246, 255, 255))
    @colors.push(Gosu::Color.rgba(160, 196, 255, 255))
    @colors.push(Gosu::Color.rgba(189, 178, 255, 255))
    @colors.push(Gosu::Color.rgba(255, 198, 255, 255))
    @colors.push(Gosu::Color.rgba(255, 255, 252, 255))

    random_cow()
  end

  def random_cow
    @head_actual = @heads.sample
    @body_actual = @bodies.sample
    @mouth_actual = @mouths.sample
    @ears_actual = @ears.sample
    @eyes_actual = @eyes.sample
    @feet_actual = @feet.sample

    @background_color_actual = @colors.sample
    @frame_color_actual = @colors.sample
  end

  def draw
    Gosu.draw_rect(0, 0, WIDTH, HEIGHT, @background_color_actual)
    draw_frame(0, 0, WIDTH, HEIGHT, 24, @frame_color_actual)
    @body_actual.draw(0, 0, 0, 24, 24)
    @ears_actual.draw(0, 0, 0, 24, 24)
    @head_actual.draw(0, 0, 0, 24, 24)
    @mouth_actual.draw(0, 0, 0, 24, 24)
    @eyes_actual.draw(0, 0, 0, 24, 24)
    @feet_actual.draw(0, 0, 0, 24, 24)
  end

  def make_picture
    image =
      Gosu.render(WIDTH, HEIGHT, retro: false) do
        draw()
      end

    image.save("CowNTF_#{Time.now.to_i}.png")
  end

  def draw_frame(x, y, width, height, stroke, color)
    Gosu.draw_rect(x, y, width, stroke, @frame_color_actual)
    Gosu.draw_rect(width - stroke, y, stroke, height, @frame_color_actual)
    Gosu.draw_rect(x, height - stroke, width, stroke, @frame_color_actual)
    Gosu.draw_rect(x, y, stroke, height, @frame_color_actual)
  end

  def button_down(id)
    if id == Gosu::MsLeft
      random_cow()
      make_picture()
    end
  end
end

game = Game.new
game.show