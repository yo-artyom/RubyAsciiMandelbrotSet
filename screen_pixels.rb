class ScreenPixels
  attr_reader :w, :h

  def initialize(h, w, el = 'x')
    @w = w
    @h = h
    @el = el
    @pixels = {}

    (0..w - 1).each do |x|
      (0..h - 1).each do |y|
        @pixels[[x,y]] = el.green
      end
    end
  end

  def to_s
    (0..w - 1).map do |x|
      (0..h - 1).map do |y|
        @pixels[[x,y]]
      end.join("")
    end.join("\n")
  end

  def update(x, y, el)
    @pixels[[x,y]] = el
  end

  def iterate
    (0..w - 1).each do |x|
      (0..h - 1).each do |y|
        yield(x, y)
      end
    end
  end
end
