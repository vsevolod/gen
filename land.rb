class Land
  attr_reader :area

  def initialize(row_count, column_count)
    @area = Matrix.build(row_count, column_count) { nil }
  end

  def []=(x, y, v)
    area.send(:set_element, x, y, v)
  end

  def [](x, y)
    area[x, y]
  end

  # Result: [x, y]
  def rand_field
    [
      SecureRandom.rand(area.column_count),
      SecureRandom.rand(area.row_count)
    ]
  end

  def move_to(mite, direction)
    x = mite.x
    y = mite.y

    case direction
    when :top then y -= 1
    when :right then x += 1
    when :bottom then y += 1
    when :left then x -= 1
    end

    y = area.row_count + y if y < 0
    x = area.column_count + x if x < 0
    y = y - area.row_count if y >= area.row_count
    x = x - area.column_count if x >= area.column_count

    case area[x, y]
    when Mite
      return
    when Food
      mite.info.grow_up(-1 * area[x, y].lives)
    end

    self[mite.x, mite.y] = nil
    self[x, y] = mite
    mite.x = x
    mite.y = y
  end
end
