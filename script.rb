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
      # px = 0
      # py = 0
      x = px - H/2
      y = py - W/2

      x = (@scale * x).round(2)
      y = (@scale * y).round(2)

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
SCALE = 1
CONST = -0.44 + 0.55i

@screen = ScreenPixels.new(W, H)

scale = SCALE
5.times do

  mset = MandelbrotSet.new(W * scale, H * scale, CONST)
  Updater.new(@screen, mset, scale).call
  scale = scale / 4.0

  system("clear")
  puts @screen.print
  sleep(3)
end
