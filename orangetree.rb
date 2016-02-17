class Orangetree
    
  def initialize name
    @name = name
    @height = 1     # tree begins at 1m
    @age = 1
    @fruitproduced = 0
    
    puts @name + ' is planted (he\'s 1 btw).'
  end
    
    
  def age
    puts 'Your tree is ' + @age.to_s + ' years old.'
  end
    
  def oneYearPasses
     @height = @height + 2
     @age = @age + 1
     puts 'Your tree ' + @name + ' is now ' + @age.to_s + ' and ' + @height.to_s + ' metres tall!'
    if @age > 5
      @fruitproduced = @age + rand(4)
    end
  end
     
  def countTheOranges
      puts 'Your tree has ' + @fruitproduced.to_s + ' oranges.'
  end
  
  def pickAnOrange
    if @fruitproduced > 1 
      @fruitproduced = @fruitproduced -1
      puts 'You have a delicious orange!'
    else 
        puts 'There is no fruit yet'
    end
  end 
     
end
  
tree = Orangetree.new 'Bob' 
tree.oneYearPasses
tree.oneYearPasses
tree.oneYearPasses
tree.countTheOranges
tree.age 
tree.oneYearPasses
tree.oneYearPasses
tree.oneYearPasses
tree.oneYearPasses
tree.oneYearPasses
tree.countTheOranges
tree.pickAnOrange
tree.countTheOranges
tree.oneYearPasses
tree.countTheOranges