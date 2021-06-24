require "gosu"
require "easing"

require_relative "configuration"
require_relative "moveable"
require_relative "laser_flash"
require_relative "explosion"
require_relative "bullet"
require_relative "engine"
require_relative "player"
require_relative "background"
require_relative "enemies_spawner"
require_relative "enemies_basket"
require_relative "enemies/blaster"
require_relative "enemies/dummy"

# The Main Class
class Game < Gosu::Window
  def initialize
    super Configuration::WINDOW_WIDTH, Configuration::WINDOW_HEIGHT
    self.caption = "SpaceShip War"

    @background = Background.new("#{__dir__}/images/Background.png")
    @player = Player.new(Configuration::WINDOW_WIDTH / 2, Configuration::WINDOW_HEIGHT - 100)
    @enemies = []
    @enemy_spawner = EnemiesSpawner.new

    @clip_shot = Gosu::Sample.new("#{__dir__}/sounds/sfx_laser1.ogg")
    @clip_explosion = Gosu::Sample.new("#{__dir__}/sounds/explosionCrunch_000.ogg")
  end

  def update
    @background.update
    actors_updates

    check_collisions_bullets_enemies

    if @player.is_alive?
      check_collisions_bullets_player
      check_collisions_enemies_player
    end

    @enemy_spawner.update
  end

  def actors_updates
    @player.update

    Bullet.all.each(&:update)
    EnemiesBasket.enemies.each(&:update)
    Explosion.all.each(&:update)
    LaserFlash.all.each(&:update)
  end

  def draw
    @background.draw
    @player.draw
    Bullet.all.each(&:draw)
    EnemiesBasket.enemies.each(&:draw)
    Explosion.all.each(&:draw)
    LaserFlash.all.each(&:draw)
  end

  def button_down(button_id)
    case button_id
    when Gosu::KB_ESCAPE
      close
    when Gosu::KB_SPACE
      @player.shoot
      @clip_shot.play
    else
      super
    end
  end

  def check_collisions_bullets_enemies
    Bullet.all.select { |e| e.kind == Bullet::KINDS[:player] }.each do |bullet|
      EnemiesBasket.enemies.each do |enemy|
        enemy_destroyed(enemy, bullet) if Gosu.distance(bullet.x, bullet.y, enemy.x, enemy.y) < 30
      end
    end
  end

  def check_collisions_bullets_player
    Bullet.all.select { |e| e.kind == Bullet::KINDS[:enemy] }.each do |bullet|
      player_destroyed(bullet) if Gosu.distance(bullet.x, bullet.y, @player.x, @player.y) < 30
    end
  end

  def check_collisions_enemies_player
    EnemiesBasket.enemies.each do |enemy|
      player_destroyed_by_enemy(enemy) if Gosu.distance(enemy.x, enemy.y, @player.x, @player.y) < 80
    end
  end

  def enemy_destroyed(enemy, bullet)
    enemy.destroy
    bullet.destroy

    Explosion.new(enemy.x, enemy.y)
    @clip_explosion.play
  end

  def player_destroyed(bullet)
    bullet.destroy
    @player.destroy
    Explosion.new(@player.x, @player.y)
    @clip_explosion.play
  end

  def player_destroyed_by_enemy(enemy)
    enemy.destroy
    @player.destroy
    Explosion.new(enemy.x, enemy.y)
    Explosion.new(@player.x, @player.y)
    @clip_explosion.play
    @clip_explosion.play
  end
end

Game.new.show
