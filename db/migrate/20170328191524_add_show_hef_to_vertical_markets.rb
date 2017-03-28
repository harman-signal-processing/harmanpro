class AddShowHefToVerticalMarkets < ActiveRecord::Migration[5.0]
  def change
    add_column :vertical_markets, :show_hef, :boolean

    VerticalMarket.all.each do |v|
      v.update_column(:show_hef, !v.retail?)
    end
  end
end
