class CreditCard

  # Some standard methods to meta class
  class << self
    def help
      puts "To initiate a new CreditCard object, type CreditCard.new <number>"
      puts "On successful initialization, check validity with '.valid?' method."
    end

    def method_missing mth, *arg, &blk
      return "Sorry, the requested method '#{mth}' not yet implemented"
    end  
  end

  # Class Constructor
  def initialize number
    @number = ((number.is_a? Numeric) ? number.to_s : number.gsub(/\D+/, ''))

  	# Raise Error if number is too short or too long
  	raise ArgumentError, "Credit Card should contain digits between 13 to 16" if @number.length < 13 || @number.length > 16

  	# Lets create some instance variables
    @type, @valid = get_details
  end	

  # Some getter methods
  def valid?
  	@valid
  end

  def type
  	@type
  end

  def number
  	@number
  end


  private

  # Method to get type and validity of card
  # Returns the card type followed by true or false
  def get_details
    case @number
    when /^(34|37)/ 
      ['AMEX', ((@number.length == 15) ? luhn : false)]
    when /^6011/  
      ['Discover', ((@number.length == 16) ? luhn : false)] 
    when /^(51|52|53|54|55)/  
      ['MasterCard', ((@number.length == 16) ? luhn : false)]
    when /^4/  
      ['VISA', ((@number.length == 13 || @number.length == 16) ? luhn : false)]
    else 
      ['Unknown', false]
    end
  end

  # Main algorithm of Luhn
  def luhn
  	sum, i = 0, 1
  	@number.reverse.chars.map(&:to_i).each do |n|  	
 	  weight = i.even? ? n*2 : n 	
  	  sum += weight < 10 ? weight : weight - 9
  	  i += 1
    end
    (sum % 10).zero?
  end

  def method_missing mth, *arg, &blk
    if self.class.respond_to? mth       # Check if our Class can respond to missing method
      eval "self.class.#{mth}"          # if yes, then lets call that i.e. CreditCard.help and CreditCard.new.help both will work
    else
      return "Sorry, the requested method '#{mth}' not yet implemented"
    end
  end
  
end