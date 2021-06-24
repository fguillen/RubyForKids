class EnemiesSpawner
  attr_reader :enemy_rows

  def initialize
    @position = 0
    @enemy_size_height = 84
    @enemy_size_width = 97
    @last_spawn_position = nil

    @enemy_rows = File.read("#{__dir__}/config/enemies_waves.txt").split("\n").reverse
  end

  def update
    @position += Configuration::ENEMY_VELOCITY

    check_if_new_spawn
  end

  def check_if_new_spawn
    if (
      @last_spawn_position.nil? ||
      @position >= (@last_spawn_position + @enemy_size_height)
    )
      spawn_enemies
    end
  end

  def spawn_enemies
    row_to_spawn = (@position / @enemy_size_height.to_f).truncate
    spawn_enemies_row(row_to_spawn)
    @last_spawn_position = @position
  end

  def spawn_enemies_row(row)
    enemies_text = @enemy_rows[row]
    return if enemies_text.nil?

    enemies_text.chars.each_with_index do |char, index|
      position = (index * @enemy_size_width) + (@enemy_size_width / 2)

      if char == "x"
        spawn_dummy_at(position)
      end

      if char == "o"
        spawn_blaster_at(position)
      end
    end
  end

  def spawn_dummy_at(position_x)
    Enemy::Dummy.new(position_x, -(@enemy_size_height / 2))
  end

  def spawn_blaster_at(position_x)
    Enemy::Blaster.new(position_x, -(@enemy_size_height / 2))
  end
end
