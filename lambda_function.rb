require_relative 'crypto_currency_balance'
require_relative 'crypto_amount_list'

def lambda_handler(event:, context:)
  body = 
    CRYPTO_AMOUNT_LIST.map do |bl|
      a = CryptoCurrencyBalance.new({
        symbol: bl[:symbol],
        amount: bl[:amount]
      })

      a.set_class_balance
      a.print ? a.print+"\n" : nil
    end.compact
    body.push CryptoCurrencyBalance.print_sum
    { statusCode: 200, body: body.join }
end
