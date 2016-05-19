class Triangle
  
  def initialize(levels)
    @levels = levels
  end
  
  def rows
    rows = [[1]]
    (1..@levels-1).each do |level|
      rows[level] = next_row_for(rows[level-1])
    end
    rows
  end
  
  def next_row_for(current_row)
    result = []
    
    current_row.each_with_index do |num, idx|
      if idx == 0
        result << 1
      else
        result << num + current_row[idx-1] 
      end
    end
    result << 1
  end
end
