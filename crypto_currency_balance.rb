require_relative 'coin_market_cap'

class CryptoCurrencyBalance
  include CoinMarketCap
  attr_reader :symbol, :currency, :price, :amount, :currency_amount
  @@balance = {}

  def initialize(symbol, amount, currency="KRW")
    @symbol = symbol
    @amount = amount.to_f
    @currency = currency

    @currency_amount = get_currency_amount
    @@balance[symbol] = currency_amount
  end

  def print
    return nil if currency_amount == 0
    puts "#{symbol}: #{currency_amount} #{currency}"
  end

  def self.sum_balance
    @@balance.map { |k, v| v.to_f }.sum.round(2)
  end

  def self.print_sum(currency)
    puts "#{currency}: #{sum_balance} #{currency}"
  end

  private 

  def get_currency_amount
    @currency_amount ||= (amount * get_price).round(2)
  end

end

