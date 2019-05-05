require_relative 'crypto_currency_list'

class CryptoCurrencyBalance
  include CryptoCurrencyList
  @@balance = {}

  def initialize(symbol:, amount:, currency: "KRW")
    @symbol = symbol
    @amount = amount.to_f
    @currency = currency
  end

  def print
    return if blocked?
    "#{symbol}: #{currency_amount} #{currency}"
  end

  def set_class_balance
    return if blocked?
    @@balance[symbol] ||= currency_amount
  end

  protected

  attr_reader :symbol, :amount, :currency

  private

  def blocked?
    return true if currency_amount == 0
    block_amount = 
      case currency
      when "KRW" then 1000000
      end
    currency_amount <= block_amount
  end

  def currency_amount
    @currency_amount ||= (amount * get_price).round(2)
  end

end

class CryptoCurrencyBalance
  class << self
    def print_sum(currency: "KRW")
      "#{currency}: #{sum_balance} #{currency}"
    end

    private 

    def sum_balance
      @@balance.inject(0) { |sum, arr| sum + arr[1] }.round(2)
    end
  end
end

