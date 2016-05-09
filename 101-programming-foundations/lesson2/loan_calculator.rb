# Loan Calculator Program

# Program Methods

def prompt(message)
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

prompt("Welcome to the Loan Repayment Calculator")

# Program loop whilst final 'Would you like to try again' response is true.

loop do
  
  # 3 required inputs
  
  prompt("What is the total loan amount?")
  
  loan_amount = ''
  loop do
    loan_amount = Kernel.gets().chomp()
    
    if number?(loan_amount)
      break
    else
      prompt("Please enter a number greater than 0")
    end
  end
  
  prompt("What is the Annual Percentage Rate (APR)?")
  prompt("Example: 5 for 5% or 3.2 for 3.2%")
  
  annual = ''
  loop do
    annual = Kernel.gets().chomp()
    
    if number?(annual)
      break
    else
      prompt("Please enter a percentage greater than 0")
    end
  end
  
  prompt("What is the loan duration in years?")
  
  loan_years = ''
  loop do
    loan_years = Kernel.gets().chomp()
  
    if number?(loan_years)
      break
    else
      prompt("Please enter a number greater than 0")
    end
  end
  
  # Calculations
  
  annual_rate = annual.to_i / 100.0
  loan_months = loan_years.to_f * 12.0
  monthly_rate = annual_rate.to_f / 12.0
  monthly_payments = loan_amount.to_f * (monthly_rate.to_f * (1 + monthly_rate.to_f)**loan_months.to_f) / ((1 + monthly_rate.to_f)**loan_months.to_f - 1)
  
  # Result
  
  Kernel.puts("You annual monthly payment is $#{monthly_payments}")
  
  prompt("Would you like to make another calculation?")
  answer = Kernel.gets().chomp()
  break unless answer.downcase().start_with?('y')
end

prompt("Thanks for using the Loan Repayment Calculator!")
