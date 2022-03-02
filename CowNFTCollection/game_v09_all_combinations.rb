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
    @colors.push(Gosu::Color.rgba(255, 173, 173, 255));
    @colors.push(Gosu::Color.rgba(253, 255, 182, 255));
    @colors.push(Gosu::Color.rgba(155, 246, 255, 255));
    @colors.push(Gosu::Color.rgba(189, 178, 255, 255));
    @colors.push(Gosu::Color.rgba(255, 255, 252, 255));

    @names = File.read("#{__dir__}/assets/names.txt").split("\n")

    @font = @font = Gosu::Font.new(self, "#{__dir__}/assets/VT323-Regular.ttf", 20)

    @cows = generate_cows();
    @cows = @cows.shuffle # it is boring to have them sorted :)

    @actual_cow_index = 0;
  end

  def generate_cows
    puts "all_cows()"
    used_names = []
    counter = 0;
    cows = []

    @heads.each do |head|
      @bodies.each do |body|
        @mouths.each do |mouth|
          @ears.each do |ear|
            @eyes.each do |eye|
              @feet.each do |foot|
                @colors.each do |background_color|
                  @colors.each do |frame_color|

                    name = random_name()
                    while(used_names.include?(name)) # TODO: very danger, it can become infinite
                      name = random_name()
                    end

                    cow = Cow.new(
                      head: head,
                      body: body,
                      mouth: mouth,
                      ear: ear,
                      eye: eye,
                      foot: foot,
                      background_color: background_color,
                      frame_color: frame_color,
                      name: name
                    )

                    puts "[#{counter}] name: #{cow.name}"
                    cows.push(cow)

                    used_names.push(name)
                    counter += 1
                  end
                end
              end
            end
          end
        end
      end
    end

    return cows;
  end

  def draw
    cow = @cows[@actual_cow_index]
    cow.draw
    cow.make_picture(@actual_cow_index)

    @actual_cow_index += 1

    if @actual_cow_index == @cows.length
      puts "All done!"
      exit
    end
  end

  def random_name
    return "#{@names.sample.capitalize} #{@names.sample.capitalize}"
  end
end

class Cow
  attr_reader :name

  def initialize(head:, body:, mouth:, ear:, eye:, foot:, background_color:, frame_color:, name:)
    @head = head
    @body = body
    @mouth = mouth
    @ear = ear
    @eye = eye
    @foot = foot
    @background_color = background_color
    @frame_color = frame_color
    @name = name
  end

  def draw
    Gosu.draw_rect(0, 0, WIDTH, HEIGHT, @background_color)
    draw_frame(0, 0, WIDTH, HEIGHT, 24, @frame_color)
    @body.draw(0, 0, 0, 24, 24)
    @ear.draw(0, 0, 0, 24, 24)
    @head.draw(0, 0, 0, 24, 24)
    @mouth.draw(0, 0, 0, 24, 24)
    @eye.draw(0, 0, 0, 24, 24)
    @foot.draw(0, 0, 0, 24, 24)
  end

  def draw_frame(x, y, width, height, stroke, color)
    Gosu.draw_rect(x, y, width, stroke, @frame_color)
    Gosu.draw_rect(width - stroke, y, stroke, height, @frame_color)
    Gosu.draw_rect(x, height - stroke, width, stroke, @frame_color)
    Gosu.draw_rect(x, y, stroke, height, @frame_color)
  end

  def make_picture(index)
    puts "Make_picture: #{index.to_s.rjust(3, "0")} - #{@name}"

    image =
      Gosu.render(WIDTH, HEIGHT, retro: false) do
        draw()
      end

    image.save("CowNTF - #{index.to_s.rjust(3, "0")} - #{@name}.png")
  end
end

game = Game.new
game.show
