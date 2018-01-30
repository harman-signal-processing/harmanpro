class AddPreviewCodeToVerticalMarkets < ActiveRecord::Migration[5.1]
  def change
    add_column :vertical_markets, :preview_code, :string
  end
end
