require 'pry'
require_relative 'palette'
require_relative 'mandelbrot_set'
require_relative 'screen_pixels'

class Updater

  def initialize(screen_pixels, mandelbrot_set)
    @screen_pixels = screen_pixels
    @mandelbrot_set = mandelbrot_set
  end

  def call
    @screen_pixels.iterate do |px, py|
      # px = 0
      # py = 0
      x = px - H/2
      y = py - W/2

      x = (SCALE * x).round(2)
      y = (SCALE * y).round(2)

      puts "calc for #{x} #{y} D: #{px}, #{py}"
      if @mandelbrot_set.check(x,y)
        @screen_pixels.update(px, py, 'x'.bg_blue)
      else
        @screen_pixels.update(px, py, '●'.black)
      end
    end
  end
end

H = 60
W = 180
SCALE = 0.1

@screen = ScreenPixels.new(W, H)
@mset = MandelbrotSet.new(W * SCALE, H * SCALE, 0 + 0i)

# binding.pry
Updater.new(@screen, @mset).call
puts @screen.print
