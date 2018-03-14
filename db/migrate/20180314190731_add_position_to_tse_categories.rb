class AddPositionToTseCategories < ActiveRecord::Migration[5.1]
  def change
    add_column :tse_categories, :position, :integer
  end
end
