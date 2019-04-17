class LocationInfo::LocationSupportedCountry < ApplicationRecord
  belongs_to :location, foreign_key: 'location_info_location_id', class_name: 'LocationInfo::Location'
  belongs_to :country, foreign_key: 'location_info_country_id', class_name: 'LocationInfo::Country'  
  
  validates :location_info_location_id, presence: true
  validates :location_info_country_id, presence: true, uniqueness: {scope: :location_info_location_id}  
end
