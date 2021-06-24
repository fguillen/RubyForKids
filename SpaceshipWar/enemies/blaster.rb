module Enemy
  class Blaster
    attr_reader :x, :y

    def initialize(x, y)
      @image = Gosu::Image.new("#{__dir__}/../images/enemyBlack4.png")
      @x = x
      @original_x = x
      @y = y
      @velocity = Configuration::ENEMY_VELOCITY
      EnemiesBasket.enemies.push(self)
    end

    def update
      @y += @velocity
      @x = @original_x + Math.cos(Gosu.milliseconds / 200.to_f) * 100
      check_if_shoot
    end

    def draw
      @image.draw_rot(@x, @y, Configuration::Z_ENEMY)
    end

    def check_if_shoot
      if rand(1000) < 4
        shoot
      end
    end

    def shoot
      Bullet.new(@x, @y + 40, Configuration::ENEMY_BULLET_IMAGE, Configuration::ENEMY_BULLET_VELOCITY, Bullet::KINDS[:enemy])
      LaserFlash.new(@x, @y + 40)
    end

    def destroy
      EnemiesBasket.enemies.delete(self)
    end
  end
end
