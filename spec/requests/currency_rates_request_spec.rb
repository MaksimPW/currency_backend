require 'rails_helper'

RSpec.describe 'Partner', type: :request do
  let!(:currency_usd) { create(:currency, name: 'USD') }
  let!(:currency_eur) { create(:currency, name: 'EUR') }
  let!(:currency_rub) { create(:currency, name: 'RUB') }

  context '#index' do
    it 'response 200' do
      get '/api/v1/rates'
      expect(response.content_type).to eq('application/json')
      expect(response).to have_http_status(200)
    end

    %w(datasets labels).each do |attr|
      it "json contains #{attr}" do
        get "/api/v1/rates"
        expect(response.body).to have_json_path("data/#{attr}")
      end
    end

  end

  context '#average_rate' do
    it 'response 200' do
      get '/api/v1/average_rate'
      expect(response.content_type).to eq('application/json')
      expect(response).to have_http_status(200)
    end

    %w(average_buy average_sell).each do |attr|
      it "json contains #{attr}" do
        get "/api/v1/average_rate"
        expect(response.body).to have_json_path("data/#{attr}")
      end
    end
  end
end