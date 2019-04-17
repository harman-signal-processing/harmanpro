class LocationInfo::LocationRegion < ApplicationRecord
  belongs_to :location, foreign_key: 'location_info_location_id'
  belongs_to :region, foreign_key: 'location_info_region_id'
  
  validates :location_info_location_id, presence: true
  validates :location_info_region_id, presence: true, uniqueness: {scope: :location_info_location_id}
end
