class CreateTseCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :tse_categories do |t|
      t.string :name
      t.integer :parent_id

      t.timestamps
    end
    add_index :tse_categories, :parent_id
  end
end
