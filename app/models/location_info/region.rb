class LocationInfo::Region < ApplicationRecord
  extend FriendlyId
  friendly_id :name

  validates :name, presence: true, uniqueness: { case_sensitive: false }

  has_many :region_to_locations_association, dependent: :destroy, foreign_key: 'location_info_region_id', class_name: 'LocationInfo::LocationRegion'
  has_many :locations, through: :region_to_locations_association, source: :location, class_name: 'LocationInfo::Location'

  scope :not_associated_with_this_location, -> (location) {
    region_ids_already_associated_with_this_location = LocationInfo::LocationRegion.where("location_info_location_id = ?", location.id).map{|location_region| location_region.location_info_region_id }
    regions_not_associated_with_this_location = LocationInfo::Region.where.not(id: region_ids_already_associated_with_this_location)
    regions_not_associated_with_this_location
  }

end
