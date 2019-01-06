require_relative 'coin_market_cap'
require_relative 'coin_gecko'

module CryptoCurrencyList
  def get_price
    return 1 if symbol == "KRW"
    list = [CoinGecko.new(symbol: symbol, currency: currency),
            CoinMarketCap.new(symbol: symbol, currency: currency)]
    list.map { |c| c.get_price }.reject { |p| p == 0 }.min.to_f
  end
end
