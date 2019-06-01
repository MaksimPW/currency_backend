require 'rails_helper'

RSpec.describe Currency, type: :model do
  it { should validate_presence_of(:name) }
  it { should have_many(:currency_rates_from).with_foreign_key('currency_from').class_name('CurrencyRate')  }
  it { should have_many(:currency_rates_to).with_foreign_key('currency_to').class_name('CurrencyRate')  }
end
