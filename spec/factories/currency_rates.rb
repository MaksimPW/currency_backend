FactoryBot.define do
    factory :currency_rate do
      time { DateTime.current }
      buy 60
      sell 65
    end
  end