require "gosu"

WIDTH = 600
HEIGHT = 400


class Game < Gosu::Window
  def initialize
    super(WIDTH, HEIGHT)
    @images = Gosu::Image.load_tiles("#{__dir__}/assets/Food.png", 16, 16, { retro: true })
    @hud = HUD.new

    @bread = Food.new(@images[0], "bread", 0, 0)
    @chocolate = Food.new(@images[1], "chocolate", 64, 0)
  end

  def draw
    @hud.draw
    @bread.draw
    @chocolate.draw
  end
end

class Food
  def initialize(image, name, x, y)
    @image = image
    @name = name
    @x = x
    @y = y

    @scale = 4
  end

  def draw
    @image.draw(@x, @y, 0, @scale, @scale)
  end
end

class HUD
  def initialize
    @selected_food_name = "no selected"
    @font = Gosu::Font.new(32, { name: "#{__dir__}/assets/VT323-Regular.ttf" } )
  end

  def select_food(food_name)
    @selected_food_name = food_name
  end

  def draw
    @font.draw_text(@selected_food_name, 0, HEIGHT - 32, 0)
  end
end

game = Game.new
game.show
