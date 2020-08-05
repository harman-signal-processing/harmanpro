class ContactInfo::TerritorySupportedCountry < ApplicationRecord
  belongs_to :territory, foreign_key: 'contact_info_territory_id', class_name: 'ContactInfo::Territory'
  belongs_to :country, foreign_key: 'location_info_country_id', class_name: 'LocationInfo::Country'  
  
  validates :contact_info_territory_id, presence: true
  validates :location_info_country_id, presence: true, uniqueness: {scope: :contact_info_territory_id, case_sensitive: false}      
end  #  class ContactInfo::TerritorySupportedCountry < ApplicationRecord
