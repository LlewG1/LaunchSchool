require 'yaml'
MESSAGES = YAML.load_file('calculator_messages.yml')
LANGUAGE = 'en'

def messages(message, lang='en')
  MESSAGES[lang][message]
end

def prompt(key) 
  message = messages(key, LANGUAGE)
  Kernel.puts("=>#{message}")
end

def prompt2(message)
  Kernel.puts("=> #{message}")
end

def integer?(input)
  input.to_i.to_s == input
end

def float?(input)
  input.to_f.to_s == input
end

def number?(input)
  integer?(input) || float?(input)
end

def operation_to_message(op)
  case op
  when '1'
    'Adding'
  when '2'
    'Subtracting'
  when '3'
    'Multiplying'
  when '4'
    'Dividing'
  end
end

prompt('welcome')

name = ''
loop do
  name = Kernel.gets().chomp()
  
  if name.empty?()
    prompt('valid_name')
  else
    break
  end
end

prompt2("Hi #{name}")

loop do # main loop
  number1 = ''
  loop do 
    prompt('first_number')
    number1 = Kernel.gets().chomp()
    
    if number?(number1)
      break
    else 
      prompt('not_valid')
    end
  end
  
  number2 = ''
  loop do
    prompt('second_number')
    number2 = Kernel.gets().chomp()
    
    if number?(number2)
      break
    else
      prompt('not_valid')
    end
  end
  
  prompt('operator_prompt')
  
  operator = ''
  loop do
    operator = Kernel.gets().chomp()
    
    if %w(1 2 3 4).include?(operator)
      break
    else
      prompt('choose')
    end
  end
  
  prompt2("#{operation_to_message(operator)} the two numbers...")
  
  result = case operator 
           when '1'
             number1.to_i() + number2.to_i()
           when '2'
             number1.to_i() - number2.to_i()
           when '3'
             number1.to_i() * number2.to_i()
           when '4'
             number1.to_f() / number2.to_f()
          end
  
  prompt2("The result is #{result}")
  
  prompt('again')
  answer = Kernel.gets().chomp()
  break unless answer.downcase().start_with?('y')
end

prompt('thankyou')
