  # Attempt 1

# class CircularBuffer
#   class BufferEmptyException < StandardError; end
#   class BufferFullException < StandardError; end
       
#   attr_reader :buffer
  
#   def initialize(num)
#     @buffer = []
#     @length = num
#   end
  
#   def read
#     raise BufferEmptyException unless @buffer != []
    
#     @buffer.shift
#   end
  
#   def write(entry)
#     raise BufferFullException unless @length != @buffer.length
    
#     @buffer.push(entry) unless entry == nil
#   end
  
#   def write!(entry)
#     @buffer.length == @length ? (@buffer.shift && @buffer.push(entry) unless entry == nil) : write(entry)
#   end
  
#   def clear
#     @buffer = []
#   end
# end

  # Attempt 2
  
class CircularBuffer
   class BufferEmptyException < Exception; end
   class BufferFullException < StandardError; end
       
  attr_accessor :buffer
  attr_reader :max_length
  
  def initialize(num)
    @buffer = []
    @max_length = num
  end
  
  def read
    buffer.shift or raise BufferEmptyException
  end
  
  def write(entry)
    update_buffer(entry) { raise BufferFullException }
  end
  
  def write!(entry)
    update_buffer(entry) { buffer.shift }
  end

  def clear
    @buffer = []
  end
  
  private 

  def update_buffer(entry)
    return if entry.nil?
    yield if buffer.length == max_length
    buffer << entry
  end
end

# buffer = CircularBuffer.new(6)

# buffer.write '1'
# p buffer.read
# buffer.write '2'
# p buffer.read


