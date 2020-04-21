class AddHideImageToVerticalMarkets < ActiveRecord::Migration[5.2]
  def change
    add_column :vertical_markets, :hide_image, :boolean
  end
end
