class Background
  def initialize(image_path)
    @image = Gosu::Image.new(image_path)
    @x = Configuration::WINDOW_WIDTH / 2
    @y = 0
    @velocity = 1
  end

  def update
    scroll
  end

  def scroll
    @y += @velocity

    if @y > Configuration::WINDOW_HEIGHT
      @y -= @image.height
    end
  end

  def draw
    @image.draw_rot(@x, @y - @image.height, Configuration::Z_BACKGROUND)
    @image.draw_rot(@x, @y, Configuration::Z_BACKGROUND)
    @image.draw_rot(@x, @y + @image.height, Configuration::Z_BACKGROUND)
  end
end
