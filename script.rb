require 'pry'

require_relative 'palette'
require_relative 'mandelbrot_set'
require_relative 'screen_pixels'

class Updater

  def initialize(screen_pixels, mandelbrot_set, scale)
    @screen_pixels = screen_pixels
    @scale = scale
    @mandelbrot_set = mandelbrot_set
  end

  def call
    @screen_pixels.iterate do |px, py|
      # Move (0,0) to display center
      x = px - H/2
      y = py - W/2

      x = (@scale * x).round(2)
      y = (@scale * y).round(2)


      check = @mandelbrot_set.check(x,y)
      if check == 1
        @screen_pixels.update(px, py, 'x'.bg_blue)
      elsif check == 2
        @screen_pixels.update(px, py, 'x'.bg_red)
      elsif check == 3
        @screen_pixels.update(px, py, 'x'.bg_cyan)
      elsif check == 4
        @screen_pixels.update(px, py, 'x'.bg_green)
      elsif check == 5
        @screen_pixels.update(px, py, 'x'.bg_magenta)
      elsif check == 6
        @screen_pixels.update(px, py, 'x'.bg_black)
      else
        @screen_pixels.update(px, py, '●'.black)
      end
    end
  end
end

H = 60
W = 170
SCALE = 1
CONST = 0.44 + 0.44i
# CONST = 2 + 1.324i

@screen = ScreenPixels.new(W, H)

scale = SCALE
20.times do
  mset = MandelbrotSet.new(W * scale, H * scale, CONST)

  Updater.new(@screen, mset, scale).call
  scale = scale * 0.8

  sleep(0.5)

  system 'clear'
  puts @screen
end
