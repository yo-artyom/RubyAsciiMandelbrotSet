class MandelbrotSet
  attr_accessor :const

  def initialize(w, h, const)
    @w = w
    @h = h
    @const = const
  end

  MAX_ITERATION = 300
  RADIUS        = 3.0

  # true - belongs
  # false - doesn't
  def check(x, y)
    calc(RADIUS, const, x + y * 1i)
  end

  private
  # z(0) = z
  # f(z) = f(z-1) ** 2 + c
  # belongs to set in R- true
  # leave the radius R - false
  def calc(radius, const, point)
    prev_value = point

    (1..MAX_ITERATION).to_a.all? do
      (prev_value = prev_value ** 2 + const).abs < radius
    end
  end

  def check_point(x, y)
    raise "No such key #{x + y*1i}" unless @set.key? [x.to_f, y.to_f]
    @set[[x.to_f,y.to_f]]
  rescue
    binding.pry
  end
end


# Ideas:
# Iterate other way
# Check for oscillations
# Use symmethry
