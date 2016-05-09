  # Part 1

# level_1 = "outer-most variable"

# [1, 2, 3].each do |n|                     # block creates a new scope
#   level_2 = "inner variable"

#   ['a', 'b', 'c'].each do |n2|            # nested block creates a nested scope
#     level_3 = "inner-most variable"

#     # all three level_X variables are accessible here
#   end

#   # level_1 is accessible here
#   # level_2 is accessile here
#   # level_3 is not accessible here

# end

# level_1 is accessible here
# level_2 is not accessible here
# level_3 is not accessible here


  # Part 2

# def call_me(some_code)
#   some_code.call            # call will execute the "chunk of code" that passed in
# end

# name = "Robert"
# chunk_of_code = Proc.new {puts "hi #{name}"}

# call_me(chunk_of_code)

  # Part 3 
  # Example of binding - Closures keep track of surrounding environment/context.

def call_me(some_code)
  some_code.call
end

name = "Robert"
chunk_of_code = Proc.new {puts "hi #{name}"}
name = "Griffin III"        # re-assign name after Proc initialization

call_me(chunk_of_code)