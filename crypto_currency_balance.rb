require_relative 'coin_market_cap'

class CryptoCurrencyBalance
  attr_reader :symbol, :amount, :currency, :id
  @@balance = 0

  def initialize(symbol, amount, currency="KRW")
    @symbol = symbol
    @amount = amount.to_f
    @currency = currency
    @cmc = CoinMarketCap.new(symbol, currency)
  end

  def calculate
    (amount * @cmc.price).round(2)
  end

  def sum_balance
    @@balance += calculate
  end

  def print
    return nil if calculate == 0
    puts "#{symbol}: #{calculate} #{currency}"
  end

  def self.print_sum(currency)
    puts "#{currency}: #{@@balance.round(2)} #{currency}"
  end

end

