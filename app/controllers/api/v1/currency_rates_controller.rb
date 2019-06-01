class Api::V1::CurrencyRatesController < ApplicationController
  def index
    curs_from = params[:from] || ['EUR', 'USD']
    cur_to = params[:to] || 'RUB'
    type = params[:type] || 'sell'
    limit = params[:limit] || 24

    @datasets = CurrencyRate.rate_datasets(curs_from, cur_to, type, limit)
    @labels = CurrencyRate.rate_labels(limit)
  end

  def average_rate
    cur_from = params[:from] || 'USD'
    cur_to = params[:to] || 'RUB'
    limit = params[:limit] || 24

    @average_rate = CurrencyRate.average_rate(cur_from, cur_to, limit)
  end
end