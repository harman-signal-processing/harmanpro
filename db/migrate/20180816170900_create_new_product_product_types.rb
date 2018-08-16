class CreateNewProductProductTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :new_product_product_types do |t|
      t.integer :new_product_id
      t.integer :product_type_id

      t.timestamps
    end
    add_index :new_product_product_types, :new_product_id
    add_index :new_product_product_types, :product_type_id
  end
end
