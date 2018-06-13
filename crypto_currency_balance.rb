require_relative 'coin_market_cap'

class CryptoCurrencyBalance < CoinMarketCap
  attr_reader :amount, :currency_amount
  @@balance = {}

  def initialize(symbol, amount, currency="KRW")
    super(symbol, currency)
    @amount = amount.to_f
    @currency_amount = get_currency_amount
    @@balance[id.to_s] = currency_amount
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
    @currency_amount ||= (amount * price).round(2)
  end

end

