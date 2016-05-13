  # Final Code
  
class DNA
  def initialize(strand)
    @original_strand = strand
  end
  
  def hamming_distance(dist)
    @original_strand.split('').first(dist.length)
      .select.with_index {|letter, idx| letter != dist.split('')[idx]}.length
  end
end  
  
  

  # Attempt 1

# class DNA
  
#   def initialize(strand)
#     @original_strand = strand
#   end
  
#   def hamming_distance(strand)
#     hamming_distance = 0
#     count = 0
#     second_strand = strand.split('')
#     first_strand = @original_strand.split('').first(second_strand.size)
    
#     first_strand.each do |letter|
#       if letter != second_strand[count]
#         hamming_distance += 1
#       end
      
#       count += 1
#     end
    
#     hamming_distance
#   end
# end

  # Attempt 2

# class DNA
  
#   def initialize(strand)
#     @original_strand = strand
#   end
  
#   def hamming_distance(strand)
#     hamming_distance = 0
#     count = 0

#     @original_strand.split('').first(strand.length).each do |letter|
#       hamming_distance += 1 unless letter == strand.split('')[count]
#       count += 1
#     end
#     hamming_distance
#   end
# end

  # Attempt 3 
  
# class DNA
  
#   def initialize(strand)
#     @original_strand = strand
#   end
  
#   def hamming_distance(strand)
#     hamming_distance = 0
#     second_strand = strand.split('')
#     first_strand = @original_strand.split('').first(second_strand.size)
    
#     first_strand.each do |letter|
#       if letter != second_strand.first
#         hamming_distance += 1
#       end
#       second_strand = second_strand.drop!(1)
#     end
    
#     hamming_distance
#   end
# end

  # Attempt 4

# class DNA
#   def initialize(strand)
#     @original_strand = strand
#   end
  
#   def hamming_distance(strand)
#     @original_strand.split('').first(strand.length).select.with_index { |letter, index| letter != strand.split('')[index] }.length
#   end
# end

  # Attempt 5

# class DNA
  
#   def initialize(strand)
#     @original_strand = strand
#   end
  
#   def hamming_distance(strand)
#     hamming_distance = 0

#     @original_strand.split('').first(strand.length).each_with_index do |letter, index|
#       hamming_distance += 1 unless letter == strand.split('')[index]
#     end
#     hamming_distance
#   end
# end

