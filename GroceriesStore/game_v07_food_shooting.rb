require "gosu"

WIDTH = 512
HEIGHT = 400


class Game < Gosu::Window
  def initialize
    super(WIDTH, HEIGHT)
    @images = Gosu::Image.load_tiles("#{__dir__}/assets/Food.png", 16, 16, { retro: true })
    @hud = HUD.new
    @button_shuffle = ButtonShuffle.new(WIDTH - 120, HEIGHT - 60)
    @names = [
      "bread", "chocolate", "hot beer", "poison", "soda", "muffing",
      "sushi tuna", "sushi veggie", "hot beer", "pork", "honey", "canned food",
      "apple", "rotten apple", "radish", "potato", "eggs", "raw honey", "pineapple", "bacon",
      "tap beer", "steak", "wine", "fish", "cheese", "roasted chicken", "bread", "eggplant",
      "red chili", "green chili", "nuts", "prawn"
    ]
    @max_images_per_row = 8
    @all_food = create_food_elements(@names)
    start_round();
  end

  def choose_food_to_shoot
    @food_to_shoot = @all_food.sample
    @hud.set_food_to_shoot(@food_to_shoot)
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

  def start_round
    shuffle_food()
    choose_food_to_shoot()
    @hud.clean_shoot_result()
  end

  def shuffle_food
    @all_food = @all_food.shuffle

    @all_food.each.with_index do |food, index|
      row = (index / @max_images_per_row).ceil
      column = index % @max_images_per_row

      food.set_position(row, column)
    end
  end

  def draw
    @hud.draw
    @button_shuffle.draw
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
      check_clicked_button()
    end
  end

  def check_clicked_food
    @all_food.each do |food|
      if (food.clicked?(mouse_x, mouse_y))
        food_shot(food)
      end
    end
  end

  def check_clicked_button
    if (@button_shuffle.clicked?(mouse_x, mouse_y))
      @button_shuffle.click_action
    end
  end

  def food_shot(food)
    if(food == @food_to_shoot)
      @hud.set_shoot_result("GOOD!")
    else
      @hud.set_shoot_result("BAD this is: #{food.name}")
    end
  end
end

class Clickable
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

class Food < Clickable
  attr_accessor :name

  def initialize(image, name, row, column)
    @image = image
    @width = @image.width
    @height = @image.height
    @scale = 4
    @name = name
    set_position(row, column)
  end

  def set_position(row, column)
    @x = column * @scale * @width
    @y = row * @scale * @height
  end

  def draw
    @image.draw(@x, @y, 0, @scale, @scale)
  end
end

class HUD
  def initialize
    @food_to_shoot = "no selected"
    @font = Gosu::Font.new(32, { name: "#{__dir__}/assets/VT323-Regular.ttf" } )
    @shoot_result = nil;
  end

  def set_food_to_shoot(food)
    @food_to_shoot = food.name
  end

  def draw
    @font.draw_text(@food_to_shoot, 200, HEIGHT - 100, 0)
    @font.draw_text(@shoot_result, 100, HEIGHT - 32, 0) if !@shoot_result.nil?
  end

  def clean_shoot_result
    @shoot_result = nil
  end

  def set_shoot_result(text)
    @shoot_result = text;
  end
end

class Button < Clickable
  def initialize(image, x, y)
    @image = Gosu::Image.new(image)
    @width = @image.width
    @height = @image.height
    @x = x
    @y = y
    @scale = 1
  end

  def click_action
  end

  def draw
    @image.draw(@x, @y)
  end
end

class ButtonShuffle < Button
  def initialize(x, y)
    super("#{__dir__}/assets/button_shuffle.png", x, y)
  end

  def click_action
    $stderr.puts "ButtonShuffle click action"
    $game.start_round
  end
end



$game = Game.new
$game.show
