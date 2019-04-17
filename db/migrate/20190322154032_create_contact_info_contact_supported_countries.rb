class CreateContactInfoContactSupportedCountries < ActiveRecord::Migration[5.2]
  def change
    create_table :contact_info_contact_supported_countries do |t|
      t.integer :position, index: true
      t.references :contact_info_contact, foreign_key: true, index: {name:'idx_contact_supported_countries_on_contact_id'}
      t.references :location_info_country, foreign_key: true, index: {name:'idx_contact_supported_countries_on_country_id'}      
      
      t.timestamps
    end
  end
end
