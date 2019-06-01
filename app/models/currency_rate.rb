class CurrencyRate < ApplicationRecord
  validates :time, :buy, :sell, presence: true

  belongs_to :currency_from, class_name: 'Currency'
  belongs_to :currency_to, class_name: 'Currency'

  def self.rate_datasets(curs_from, cur_to, type, limit)
    begin_time = DateTime.current - limit.hours
    datasets = curs_from.map { |name| { 'label': name, 'data': [] } }
    cur_to_id = Currency.find_by(name: cur_to).id

    limit.times do |i|
      rate_time = (begin_time + i.hours)
      datasets.each do |dataset|
        cur_from_id = Currency.find_by(name: dataset[:label]).id
        rate =
          CurrencyRate.where(
            time: rate_time.beginning_of_hour..rate_time.end_of_hour,
            currency_from_id: cur_from_id,
            currency_to_id: cur_to_id
          ).first

        if rate
          dataset[:data].push(rate[type])
        else
          dataset[:data].push('null')
        end
      end
    end
    datasets
  end

  def self.rate_labels(limit)
    begin_time = DateTime.current - limit.hours
    labels = []
    limit.times do |i|
      labels.push "#{(begin_time + i.hours).hour.to_s}:00"
    end
    labels
  end

  def self.average_rate(cur_from, cur_to, limit)
    cur_from_id = Currency.find_by(name: cur_from).id
    cur_to_id = Currency.find_by(name: cur_to).id

    end_time = DateTime.current.end_of_hour
    begin_time = (end_time - limit.hours).beginning_of_hour

    rates = CurrencyRate.where(
      time: begin_time..end_time,
      currency_from_id: cur_from_id,
      currency_to_id: cur_to_id
    )

    arr_buy = rates.pluck(:buy)
    average_buy = arr_buy.inject{ |sum, el| sum + el }.to_f / arr_buy.size

    arr_sell = rates.pluck(:sell)
    average_sell = arr_sell.inject{ |sum, el| sum + el }.to_f / arr_sell.size

    {
      buy: average_buy,
      sell: average_sell
    }
  end
end
