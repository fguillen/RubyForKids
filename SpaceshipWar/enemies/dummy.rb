module Enemy
  class Dummy
    attr_reader :x, :y

    def initialize(x, y)
      @image = Gosu::Image.new("#{__dir__}/../images/enemyGreen5.png")
      @x = x
      @y = y
      @velocity = Configuration::ENEMY_VELOCITY
      EnemiesBasket.enemies.push(self)
    end

    def update
      @y += @velocity
      check_if_shoot
    end

    def draw
      @image.draw_rot(@x, @y, Configuration::Z_ENEMY)
    end

    def check_if_shoot
      if rand(5000) < 4
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
