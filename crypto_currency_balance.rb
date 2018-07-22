require_relative 'coin_market_cap'

class CryptoCurrencyBalance
  include CoinMarketCap
  @@balance = {}

  def initialize(symbol:, amount:, currency: "KRW")
    @symbol = symbol
    @amount = amount.to_f
    @currency = currency
  end

  def print
    return nil if currency_amount == 0
    puts "#{symbol}: #{currency_amount} #{currency}"
  end

  def set_class_balance
    @@balance[symbol] ||= currency_amount
  end

  protected

  attr_reader :symbol, :amount, :currency

  private

  def currency_amount
    @currency_amount ||= (amount * get_price).round(2)
  end

end

class CryptoCurrencyBalance
  class << self
    def print_sum(currency: "KRW")
      puts "#{currency}: #{sum_balance} #{currency}"
    end

    private 

    def sum_balance
      @@balance.inject(0) { |sum, arr| sum + arr[1] }.round(2)
    end
  end
end

