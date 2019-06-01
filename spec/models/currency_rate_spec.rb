require 'rails_helper'

RSpec.describe CurrencyRate, type: :model do
  it { should validate_presence_of(:time) }
  it { should validate_presence_of(:buy) }
  it { should validate_presence_of(:sell) }

  it { should belong_to(:currency_from).class_name('Currency') }
  it { should belong_to(:currency_to).class_name('Currency') }

  describe '.average_rate' do
    let(:time_now) { Time.now }
    let!(:currency_usd) { create(:currency, name: 'USD') }
    let!(:currency_rub) { create(:currency, name: 'RUB') }
    let!(:rate1) { create(:currency_rate, time: time_now - 60.minutes, currency_from: currency_usd, currency_to: currency_rub) }
    let!(:rate2) { create(:currency_rate, time: time_now - 30.minutes, currency_from: currency_usd, currency_to: currency_rub) }

    it 'should receive' do
      expect(CurrencyRate).to receive(:average_rate).with('USD', 'RUB', 2)
      CurrencyRate.average_rate('USD', 'RUB', 2)
    end

    it 'calculate average rate' do
      expect(CurrencyRate.average_rate('USD', 'RUB', 2)).to eq({ buy: 60, sell: 65 })
    end
  end

  describe '.rate_datasets' do
    let(:time_now) { Time.now.beginning_of_hour + 30.minutes }
    let!(:currency_usd) { create(:currency, name: 'USD') }
    let!(:currency_eur) { create(:currency, name: 'EUR') }
    let!(:currency_rub) { create(:currency, name: 'RUB') }

    let!(:rate_usd_1) {
      create(:currency_rate,
        time: time_now - 2.hours,
        currency_from: currency_usd,
        currency_to: currency_rub,
        sell: 60,
        buy: 65
      )
    }
    let!(:rate_usd_2) {
      create(:currency_rate,
        time: time_now - 1.hours,
        currency_from: currency_usd,
        currency_to: currency_rub,
        sell: 61,
        buy: 66
      )
    }
    let!(:rate_eur_1) {
      create(:currency_rate,
        time: time_now - 2.hours,
        currency_from: currency_eur,
        currency_to: currency_rub,
        sell: 70,
        buy: 75
      )
    }
    let!(:rate_eur_2) {
      create(:currency_rate,
        time: time_now - 1.hours,
        currency_from: currency_eur,
        currency_to: currency_rub,
        sell: 71,
        buy: 76
      )
    }

    it 'should receive' do
      expect(CurrencyRate).to receive(:rate_datasets).with(['USD', 'EUR'], 'RUB', 'sell', 2)
      CurrencyRate.rate_datasets(['USD', 'EUR'], 'RUB', 'sell', 2)
    end

    context 'for sell' do
      it 'get correct dataset' do
        arr = [
          {
            label: 'USD',
            data: [60.0, 61.0]
          },
          {
            label: 'EUR',
            data: [70.0, 71.0]
          }
        ]
        expect(CurrencyRate.rate_datasets(['USD', 'EUR'], 'RUB', 'sell', 2)).to eq(arr)
      end
    end

    context 'for buy' do
      it 'get correct dataset' do
        arr = [
          {
            label: 'USD',
            data: [65.0, 66.0]
          },
          {
            label: 'EUR',
            data: [75.0, 76.0]
          }
        ]
        expect(CurrencyRate.rate_datasets(['USD', 'EUR'], 'RUB', 'buy', 2)).to eq(arr)
      end
    end
  end
end
