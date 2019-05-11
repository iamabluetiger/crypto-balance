require 'json'
require 'net/http'

class CoinMarketCap
  # CMC_LIST = JSON(Net::HTTP.get_response(URI('https://api.coinmarketcap.com/v2/listings/')).body)["data"]
  CMC_LIST = JSON(File.read("coin_list_coin_market_cap.json"))["data"]

  def initialize(symbol:, currency: "KRW")
    @symbol = symbol
    @currency = currency
  end

  def get_price
    return 0 unless get_id
    get_ticker_data.dig('quote', currency, 'price').to_f
  end

  private

  attr_reader :symbol, :currency

  def get_id
    return nil if symbol == 'LUNA'
    return 3794 if symbol == 'ATOM'
    data = -> { CMC_LIST.find { |list| list["symbol"] == symbol } || {} }
    data.call()["id"]
  end

  def get_ticker_data
    return nil unless get_id
    request("/cryptocurrency/quotes/latest?id=#{get_id}&convert=#{currency}")
  end

  def request(endpoint)
    uri = URI('https://pro-api.coinmarketcap.com/v1'+endpoint)
    http = http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(uri.request_uri)
    request['Accept'] = 'application/json'
    request['X-CMC_PRO_API_KEY'] = '40efb91c-ec27-48b6-849e-b7deb5ca596d'
    response = JSON(http.request(request).body).dig('data', get_id.to_s)
  end

end
