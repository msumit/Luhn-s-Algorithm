#!/usr/bin/ruby
require_relative 'credit_card'

cc_numbers = []

# Initiate the new CreditCard object and pass the card number
begin 
  # This while loop gets all card numbers and loops out when entered a blank line
  while 
    line = gets.chomp
    break if line.empty?
    cc_numbers << CreditCard.new(line)
  end

  # Now print the results
  cc_numbers.each do |cc|
    printf("%-28s %s \n", cc.type + ': ' + cc.number, (cc.valid? ? '(valid)' : '(invalid)'))
  end

rescue ArgumentError => e
  puts "Can't initiate the CreditCard object due to error: #{e.message}"
end