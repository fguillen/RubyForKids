require "minitest/autorun"
require_relative "test_helper"

class TestSinusoidalMovement < Minitest::Test
  def test_cos
    350.times do |e|
      num = e / 100.to_f
      puts "#{num} -> #{Math.cos(num)}"
    end
  end
end
