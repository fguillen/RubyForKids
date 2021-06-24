class Ship
  @@num_space_ships = 0

  def initialize(name)
    @name = name
    @position_x = 0
    @position_y = 0
    @speed = 0

    @@num_space_ships += 1
  end

  def get_name
    @name
  end

  def change_name(new_name)
    @name = new_name
  end

  def change_speed(new_speed)
    @speed = new_speed
  end

  def stop()
    @speed = 0
  end

  def fast()
    @speed = 10
  end

  def self.num_space_ships
    @@num_space_ships
  end

  def destroy
    @@num_space_ships -= 1
  end
end

ship_1 = Ship.new("ship_1")
puts ship_1.get_name
puts Ship.num_space_ships

ship_2 = Ship.new("ship_1")
puts ship_2.get_name
puts Ship.num_space_ships

ship_2.destroy
puts Ship.num_space_ships
