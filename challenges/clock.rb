class Clock
  def initialize(hour, min)
    @hour = hour
    @min = min
  end
  def self.at(hour, min=0)
    new(hour, min)
  end
  
  def to_s
    "#{format_number(@hour)}:#{format_number(@min)}"
  end
  
  def +(mins)
    @hour = (@hour + mins / 60) % 24 
    @min += mins % 60 
    self
  end

  def -(mins)
    self.+(-mins)
  end
  
  def ==(other_clock)
    to_s == other_clock.to_s
  end
  
  def format_number(number)
    number < 10 ? "0#{number}" : number
  end
end
