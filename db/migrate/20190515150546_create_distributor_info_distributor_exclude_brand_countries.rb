class CreateDistributorInfoDistributorExcludeBrandCountries < ActiveRecord::Migration[5.2]
  def change
    create_table :distributor_info_distributor_exclude_brand_countries do |t|
      t.references :distributor_info_distributor, foreign_key: true, index: {name:'idx_dist_exclude_on_distributor_id'}
      t.references :brand, foreign_key: true, type: :integer,  index: {name:'idx_dist_exclude_on_brands_brand_id'} 
      t.references :location_info_country, foreign_key: true, index: {name:'idx_dist_exclude_on_country_id'}
      t.timestamps
    end
  end
end
