class LocationInfo::Region < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  
  has_many :region_locations, dependent: :destroy, foreign_key: 'location_info_region_id', class_name: 'LocationInfo::LocationRegion'
  has_many :locations, source: :location, class_name: 'LocationInfo::Location'
end
