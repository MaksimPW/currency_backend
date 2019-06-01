Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'rates', to: 'currency_rates#index', format: 'json'
      get 'average_rate', to: 'currency_rates#average_rate', format: 'json'
    end
  end
end
