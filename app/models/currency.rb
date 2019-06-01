class Currency < ApplicationRecord
  validates :name, presence: true

  has_many :currency_rates_from, foreign_key: 'currency_from', class_name: 'CurrencyRate'
  has_many :currency_rates_to, foreign_key: 'currency_to', class_name: 'CurrencyRate'
end
