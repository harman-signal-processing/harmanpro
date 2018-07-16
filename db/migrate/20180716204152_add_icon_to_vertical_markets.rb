class AddIconToVerticalMarkets < ActiveRecord::Migration[5.1]
  def change
    add_column :vertical_markets, :icon_file_name, :string
    add_column :vertical_markets, :icon_file_size, :integer
    add_column :vertical_markets, :icon_content_type, :string
    add_column :vertical_markets, :icon_updated_at, :datetime
  end
end
