require "minitest/autorun"
require_relative "test_helper"

class TestEnemiesSpawner < Minitest::Test
  def test_initialize
    enemy_spawner = EnemiesSpawner.new

    assert_equal("   x", enemy_spawner.enemy_rows[0])
  end

  def test_update
    enemy_spawner = EnemiesSpawner.new
    39.times { enemy_spawner.update }
  end

  def test_update_first_spawn
    enemy_spawner = EnemiesSpawner.new
    40.times { enemy_spawner.update }
  end
end
