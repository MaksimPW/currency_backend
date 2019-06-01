namespace :app do
  desc "Save currency rates to database."
  task :get_currency_rates, [:currenciedes_from, :currency_to] => [:environment] do |task, args|
    res = Faraday.get 'https://www.tinkoff.ru/api/v1/currency_rates/'
    result = JSON.parse(res.body)
    fix_time = Time.at(result['payload']['lastUpdate']['milliseconds']/1000)

    if result['resultCode'] == 'OK'
      currencies_from = args[:currencies_from] || ['EUR', 'USD']
      currency_to = args[:currency_to] || 'RUB'
      currency_to_id = Currency.find_by(name: currency_to).id
      rates = result['payload']['rates']

      deposit_payments = rates.select {|r| r['category'] == 'DepositPayments'}
      currencies_from.each do |cur|

        res_rate = deposit_payments.select {|r|
          r['fromCurrency']['name'] == cur && r['toCurrency']['name'] == currency_to
        }.first

        currency_rate = CurrencyRate.create(
          time: fix_time,
          currency_from_id: Currency.find_by(name: cur).id,
          currency_to_id: currency_to_id,
          buy: res_rate['buy'],
          sell: res_rate['sell']
        )
      end
    end
  end
end
