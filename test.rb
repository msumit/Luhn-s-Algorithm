#!/usr/bin/ruby
require_relative 'credit_card'
require 'test/unit'

class CreditCardTest < Test::Unit::TestCase

  CARDS = [
    ['4111111111111111', 'VISA', true],
    ['4111111111111', 'VISA', false],
    ['4012888888881881', 'VISA', true],
    ['378282246310005', 'AMEX', true],
    ['6011111111111117', 'Discover', true],
    ['5105105105105100', 'MasterCard', true],
    ['5105105105105106', 'MasterCard', false],
    ['9111111111111111', 'Unknown', false]  
  ]

  def test_should_raise_error
    assert_raise ArgumentError do 
      CreditCard.new
    end
  end

  def test_should_validate_each_card
    CARDS.each do |card|
      c = CreditCard.new card[0]
      assert_equal card[1], c.type
      assert_equal card[2], c.valid?
    end
  end

end