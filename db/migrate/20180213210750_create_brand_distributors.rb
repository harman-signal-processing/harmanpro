class CreateBrandDistributors < ActiveRecord::Migration[5.1]
  def change
    create_table :brand_distributors do |t|
      t.integer :distributor_id
      t.integer :brand_id

      t.timestamps
    end
    add_index :brand_distributors, :distributor_id
    add_index :brand_distributors, :brand_id
  end
end
