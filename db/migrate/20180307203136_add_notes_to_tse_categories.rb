class AddNotesToTseCategories < ActiveRecord::Migration[5.1]
  def change
    add_column :tse_categories, :notes, :text
  end
end
