class AddBackgroundToVerticalMarkets < ActiveRecord::Migration
  def change
    add_column :vertical_markets, :background_file_name, :string
    add_column :vertical_markets, :background_content_type, :string
    add_column :vertical_markets, :background_file_size, :integer
    add_column :vertical_markets, :background_updated_at, :datetime
  end
end
