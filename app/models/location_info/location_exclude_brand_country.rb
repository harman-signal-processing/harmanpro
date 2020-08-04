class LocationInfo::LocationExcludeBrandCountry < ApplicationRecord
  belongs_to :location, foreign_key: 'location_info_location_id', class_name: 'LocationInfo::Location'
  belongs_to :country, foreign_key: 'location_info_country_id', class_name: 'LocationInfo::Country'  
  belongs_to :brand, foreign_key: 'brand_id', class_name: 'Brand'  
  
  attr_accessor :brand_country
  
  validates :location_info_location_id, presence: true
  validates :location_info_country_id, presence: true, uniqueness: {scope: [:location_info_location_id, :brand_id], case_sensitive: false}  
  validates :brand_id, presence: true, uniqueness: {scope: [:location_info_location_id, :location_info_country_id], case_sensitive: false}  
end
