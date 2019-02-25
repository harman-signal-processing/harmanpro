class CreateDistributorInfoDistributorBrands < ActiveRecord::Migration[5.2]
  def change
    create_table :distributor_info_distributor_brands do |t|
      t.references :distributor_info_distributor, foreign_key: true, index: {name:'idx_dist_info_on_brands_distributor_id'} 
      t.references :brand, foreign_key: true, type: :integer,  index: {name:'idx_dist_info_on_brands_brand_id'} 
      t.integer :position

      t.timestamps
    end
  end
end
