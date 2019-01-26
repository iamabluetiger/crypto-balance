require_relative 'crypto_currency_balance'
require_relative 'crypto_amount_list'

CRYPTO_AMOUNT_LIST.map do |bl|
  a = CryptoCurrencyBalance.new({
    symbol: bl[:symbol],
    amount: bl[:amount]
  })

  a.set_class_balance
  puts a.print if !a.print.nil?
end
puts CryptoCurrencyBalance.print_sum
