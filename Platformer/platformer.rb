require "gosu"

class Player
    def initialize(platform)
        @x = 100
        @y = 100
        @player = Gosu::Image.new("#{__dir__}/images/player.png")
        @collide = false
        @platform = platform
        @aceleration = 0
        @jumping = false
        @font = Gosu::Font.new(20, name: Gosu.default_font_name)

        @sample_jump = Gosu::Sample.new("#{__dir__}/sounds/jump.wav")
        @sample_impact = Gosu::Sample.new("#{__dir__}/sounds/impact.wav")
    end

    def jump
        return if @collide == false

        @sample_jump.play()
        @aceleration -= 5
        @collide = false
    end

    def collision
        player_feet_y = @y + @player.height
        if player_feet_y >= @platform.y
            if @collide == false
              @collide = true
              @y = @platform.y - @player.height
              @aceleration = 0
              @sample_impact.play()
            end
        else
            @collide = false
        end
    end

    def gravity
        if @collide == false
            @aceleration += 0.1
            @y += @aceleration
        end
    end

    def draw
        @player.draw(@x, @y, 0)
        debug
    end

    def debug
      @font.draw_text("x: #{@x.round(2)}, y: #{@y.round(2)}", @x + 200, @y, 0, 1, 1, Gosu::Color::BLACK)
      @font.draw_text("collide: #{@collide}", @x + 200, @y + 20, 0, 1, 1, Gosu::Color::BLACK)
      @font.draw_text("aceleration: #{@aceleration.round(2)}", @x + 200, @y + 40, 0, 1, 1, Gosu::Color::BLACK)
    end

    def move
        move_right if Gosu.button_down? Gosu::KB_RIGHT
        move_left if Gosu.button_down? Gosu::KB_LEFT
    end

    def move_right
        @x += 5
    end

    def move_left
        @x -= 5
    end

    def update
        move
        gravity
        collision
    end
end

class Platform
    def initialize
        @platform = Gosu::Image.new("#{__dir__}/images/platform.png")
        @y = 400
        @x = 50
    end

    def y
        @y
    end

    def update
    end

    def draw
        @platform.draw(@x, @y, 0)
    end
end

class Game < Gosu::Window
    def initialize
        super 680, 920
        self.caption = "Game"
        @platform = Platform.new
        @player = Player.new(@platform)
    end

    def update
        @player.update
        @platform.update
    end

    def draw
        Gosu.draw_rect(0, 0, 680, 920, Gosu::Color.new(222, 146, 53))
        @player.draw
        @platform.draw
    end

    def button_down(button_id)
        if button_id == Gosu::KB_SPACE
            @player.jump
        end
    end
end

game = Game.new
game.show
