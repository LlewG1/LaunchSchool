 # Attempt 1
 
# class School 
#   attr_reader :roster

#   def initialize
#     @roster = {}
#   end
  
#   def to_h
#     roster
#   end
  
#   def sort_school
#     @roster = @roster.sort.to_h
#     @roster.each { |grade, arr| roster[grade] = arr.sort }
#   end
  
#   def add(name, grade)
#     (roster[grade] ||= []) << name
#     sort_school
#   end
  
#   def grade(year)
#     roster[year] ||= []
#   end
# end

  # Attempt 2 with refractoring
  
class School 
  attr_reader :roster

  def initialize
    @roster = Hash.new { |roster, grade| roster[grade] = [] }
  end
  
  def to_h
    roster.sort.each { |grade, names| [grade, names.sort] }.to_h
  end
  
  def add(name, grade)
    roster[grade] << name
  end
  
  def grade(year)
    roster[year]
  end
end


school = School.new
school.add('Chelsea', 3)
school.add('Logan', 7)
school.add('Paul', 2)
school.add('Blair', 2)
school.add('Andy', 2)

p school.grade(2)
p school.grade(7)
p school.grade(8)

p school.to_h