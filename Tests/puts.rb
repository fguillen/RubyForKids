require "gosu"

class Game < Gosu::Window
  def initialize
    super 100, 100
  end

  def update
    puts "puts: #{Time.now}"
    $stderr.puts "stderr: #{Time.now}"
    $stdout.flush
  end
end

Game.new.show
