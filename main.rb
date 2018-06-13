require_relative 'crypto_currency_balance'
require_relative 'crypto_amount_list'

CRYPTO_AMOUNT_LIST.map do |bl|
  a = CryptoCurrencyBalance.new(bl[:symbol], bl[:amount])
  a.print
end
CryptoCurrencyBalance.print_sum("KRW")
