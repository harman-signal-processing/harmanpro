class CreateDistributorInfoDistributorCountries < ActiveRecord::Migration[5.2]
  def change
    create_table :distributor_info_distributor_countries do |t|
      t.integer :position, index: true
      t.references :distributor_info_distributor, foreign_key: true, index: {name:'idx_distributor_countries_on_distributor_id'}
      t.references :location_info_country, foreign_key: true, index: {name:'idx_distributor_countries_on_country_id'}
      
      t.timestamps
    end
  end
end
