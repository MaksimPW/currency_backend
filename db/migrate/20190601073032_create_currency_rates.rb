class CreateCurrencyRates < ActiveRecord::Migration[5.2]
  def change
    create_table :currency_rates do |t|
      t.datetime :time
      t.references :currency_from, index: true, foreign_key: { to_table: :currencies }
      t.references :currency_to, index: true, foreign_key: { to_table: :currencies }
      t.float :buy
      t.float :sell

      t.timestamps
    end
  end
end
