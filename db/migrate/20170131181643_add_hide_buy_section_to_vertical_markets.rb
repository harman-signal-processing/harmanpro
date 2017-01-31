class AddHideBuySectionToVerticalMarkets < ActiveRecord::Migration[5.0]
  def change
    add_column :vertical_markets, :hide_buy_section, :boolean
  end
end
