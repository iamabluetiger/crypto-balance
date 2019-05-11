require 'json'
require 'net/http'

class CoinGecko
  # CG_LIST = JSON(Net::HTTP.get_response(URI('https://api.coingecko.com/api/v3/coins/list')).body)
  CG_LIST = JSON(File.read("coin_list_coin_gecko.json"))

  def initialize(symbol:, currency: "KRW")
    @symbol = symbol.downcase
    @currency = currency.downcase
  end

  def get_price
    return 0 unless get_id
    request_price
  end

  private

  attr_reader :symbol, :currency

  def get_id
    return 'huobi-token' if symbol == 'ht'
    data = -> { CG_LIST.find { |list| list["symbol"] == symbol } || {} }
    data.call()["id"]
  end

  def request_price
    data = JSON(Net::HTTP.get_response(URI("https://api.coingecko.com/api/v3/simple/price?ids=#{get_id}&vs_currencies=#{currency}")).body)
    data.to_hash.dig(get_id, currency)
  end

end
