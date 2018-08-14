class CreateNewProductBrands < ActiveRecord::Migration[5.1]
  def change
    create_table :new_product_brands do |t|
      t.integer :new_product_id
      t.integer :brand_id

      t.timestamps
    end
    add_index :new_product_brands, :new_product_id
    add_index :new_product_brands, :brand_id
  end
end
