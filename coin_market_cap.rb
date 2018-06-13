require 'json'
require 'net/http'

class CoinMarketCap
  CMC_LIST = JSON(Net::HTTP.get_response(URI('https://api.coinmarketcap.com/v2/listings/')).body)["data"]
  attr_reader :symbol, :currency, :id, :price

  def initialize(symbol, currency)
    @symbol = symbol
    @currency = currency
    @id = get_id
    @price = get_price
  end

  private

  def get_id
    data = CMC_LIST.find { |list| list["symbol"] == symbol }
    data ? data["id"] : nil
  end

  def get_price
    return 0 unless id
    get_data['quotes'][currency]['price']
  end

  def get_data
    return nil unless id
    @data ||= JSON(Net::HTTP.get_response(URI("https://api.coinmarketcap.com/v2/ticker/#{id}/?convert=#{currency}")).body)['data']
  end

end
