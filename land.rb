class Land
  attr_reader :area

  def initialize(row_count, column_count)
    @area = Matrix.build(row_count, column_count) { nil }
  end

  def []=(i, j, v)
    @area.send(:set_element, i, j, v)
  end

  # Result: [x, y]
  def rand_field
    [
      SecureRandom.rand(area.column_count),
      SecureRandom.rand(area.row_count)
    ]
  end
end
