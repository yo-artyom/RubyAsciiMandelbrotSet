class MandelbrotSet
  attr_accessor :const

  def initialize(w, h, const)
    @w = w
    @h = h
    @const = const
  end

  MAX_ITERATION = 300
  RADIUS        = 10

  # Return values
  # true - belongs to the set
  # int - amount iterations before leaving the R
  def check(x, y)
    calc(RADIUS, const, x + y * 1i)
  end

  private
  # z(0) = z
  # f(z) = f(z-1) ** 2 + c
  def calc(radius, const, point)
    result = true
    prev_value = point

    (1..MAX_ITERATION).to_a.each do |i|
      break i if (prev_value = prev_value ** 2 + const).abs > radius
      true
    end
  end
end


# Ideas:
# Iterate other way
# Check for oscillations
# Use symmethry
