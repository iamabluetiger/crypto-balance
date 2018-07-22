require 'json'
require 'net/http'

module CoinMarketCap
  CMC_LIST = JSON(Net::HTTP.get_response(URI('https://api.coinmarketcap.com/v2/listings/')).body)["data"]

  def get_price
    return 1 if symbol == "KRW"
    return 0 unless get_id
    @_price ||= get_ticker_data['quotes'][currency]['price']
  end

  private

  def get_id
    data = -> { CMC_LIST.find { |list| list["symbol"] == symbol } || {} }
    @_id ||= data.call()["id"]
  end

  def get_ticker_data
    return nil unless get_id
    @_ticker_data ||= JSON(Net::HTTP.get_response(URI("https://api.coinmarketcap.com/v2/ticker/#{get_id}/?convert=#{currency}")).body)['data']
  end

end
