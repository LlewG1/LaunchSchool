class Matrix 
  attr_reader :rows
  
  def initialize(matrix)
    @rows = matrix.split("\n").map {|row_string| row_string.split(" ").map(&:to_i) }
  end

  def columns
    rows.transpose
  end
  
  def saddle_points
    saddle_point_coords = []
    rows.each_with_index do |row, x|
      rows.each_with_index do |number, y|
        if saddle_point?(x, y)
          saddle_point_coords << [x, y]
        end
      end
    end
    saddle_point_coords
  end
  
  def saddle_point?(x, y)
    value, row, column = rows[x][y], rows[x], columns[y]
    value == row.max && value == column.min
  end
end

