class LocationInfo::LocationSupportedBrand < ApplicationRecord
  belongs_to :location, foreign_key: 'location_info_location_id', class_name: 'LocationInfo::Location'
  belongs_to :brand, foreign_key: 'brand_id', class_name: 'Brand'  
  
  validates :location_info_location_id, presence: true
  validates :brand_id, presence: true, uniqueness: {scope: :location_info_location_id, case_sensitive: false}  
end
