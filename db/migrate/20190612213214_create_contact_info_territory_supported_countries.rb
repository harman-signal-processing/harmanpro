class CreateContactInfoTerritorySupportedCountries < ActiveRecord::Migration[5.2]
  def change
    create_table :contact_info_territory_supported_countries do |t|
      t.references :contact_info_territory, foreign_key: true, index: {name:'idx_territory_supported_countries_on_territory_id'}
      t.references :location_info_country, foreign_key: true, index: {name:'idx_territory_supported_countries_on_country_id'}
      t.timestamps
    end
  end
end
