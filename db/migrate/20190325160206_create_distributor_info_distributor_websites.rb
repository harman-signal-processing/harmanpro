class CreateDistributorInfoDistributorWebsites < ActiveRecord::Migration[5.2]
  def change
    create_table :distributor_info_distributor_websites do |t|
      t.integer :position, index: true
      t.references :distributor_info_distributor, foreign_key: true, index: {name: 'idx_distributor_websites_on_distributor_id'}
      t.references :contact_info_website, foreign_key: true, index: {name: 'idx_distributor_websites_on_website_id'}
      
      t.timestamps
    end
  end
end
