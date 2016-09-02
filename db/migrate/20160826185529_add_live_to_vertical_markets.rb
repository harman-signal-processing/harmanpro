class AddLiveToVerticalMarkets < ActiveRecord::Migration
  def up
    add_column :vertical_markets, :live, :boolean, default: true
    VerticalMarket.update_all(live: true)
  end

  def down
    remove_column :vertical_markets, :live, :boolean, default: true
  end
end
