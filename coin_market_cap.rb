require 'json'
require 'net/http'

class CoinMarketCap
  CMC_LIST = JSON(Net::HTTP.get_response(URI('https://api.coinmarketcap.com/v2/listings/')).body)["data"]

  def initialize(symbol:, currency: "KRW")
    @symbol = symbol
    @currency = currency
  end

  def get_price
    return 0 unless get_id
    get_ticker_data['quotes'][currency]['price']
  end

  private

  attr_reader :symbol, :currency

  def get_id
    data = -> { CMC_LIST.find { |list| list["symbol"] == symbol } || {} }
    data.call()["id"]
  end

  def get_ticker_data
    return nil unless get_id
    JSON(Net::HTTP.get_response(URI("https://api.coinmarketcap.com/v2/ticker/#{get_id}/?convert=#{currency}")).body)['data']
  end

end
