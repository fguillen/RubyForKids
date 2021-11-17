require "gosu"

WIDTH = 512
HEIGHT = 400


class Game < Gosu::Window
  def initialize
    super(WIDTH, HEIGHT)
    @images = Gosu::Image.load_tiles("#{__dir__}/assets/Food.png", 16, 16, { retro: true })
    @hud = HUD.new
    @names = [
      "bread", "chocolate", "hot beer", "poison", "soda", "muffing",
      "sushi tuna", "sushi veggie", "hot beer", "pork", "honey", "canned food",
      "apple", "rotten apple", "radish", "potato", "eggs", "raw honey", "pineapple", "bacon",
      "tap beer", "steak", "wine", "fish", "cheese", "roasted chicken", "bread", "eggplant",
      "red chili", "green chili", "nuts", "prawn"
    ]
    @max_images_per_row = 8
    @all_food = create_food_elements(@names)
  end

  def create_food_elements(names)
    result = []

    names.each.with_index do |name, index|
      row = (index / @max_images_per_row).ceil
      column = index % @max_images_per_row

      food = Food.new(@images[index], name, row, column)
      result.push(food)
    end

    return result
  end

  def draw
    @hud.draw
    draw_all_food
  end

  def draw_all_food
    @all_food.each do |food|
      food.draw
    end
  end

  def button_down(button_id)
    if (button_id == Gosu::MS_LEFT)
      check_clicked_food()
    end
  end

  def check_clicked_food
    @all_food.each do |food|
      if (food.clicked?(mouse_x, mouse_y))
        @hud.select_food(food.name)
      end
    end
  end
end

class Food
  attr_accessor :name

  def initialize(image, name, row, column)
    @image = image
    @width = @image.width
    @height = @image.height
    @scale = 4
    @name = name
    @x = column * @scale * @width
    @y = row * @scale * @height
  end

  def draw
    @image.draw(@x, @y, 0, @scale, @scale)
  end

  def clicked?(mouse_x, mouse_y)
    if(
      @x < mouse_x &&
      @x + (@width * @scale) > mouse_x &&
      @y < mouse_y &&
      @y + (@height * @scale) > mouse_y
    )
      return true
    end

    return false
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
