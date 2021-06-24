module Configuration
  WINDOW_WIDTH = 680
  WINDOW_HEIGHT = 920
  PLAYER_VELOCITY = 5
  ENEMY_VELOCITY = 2

  Z_BACKGROUND = 0
  Z_ENEMY = 1
  Z_PLAYER = 2
  Z_ENGINE = 1
  Z_BULLET = 3
  Z_EXPLOSION = 3
  Z_UI = 4

  PLAYER_BULLET_IMAGE = Gosu::Image.new("#{__dir__}/images/laserBlue02.png")
  PLAYER_BULLET_VELOCITY = -20

  ENEMY_BULLET_IMAGE = Gosu::Image.new("#{__dir__}/images/laserRed02.png")
  ENEMY_BULLET_VELOCITY = 10
end
