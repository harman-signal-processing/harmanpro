class LocationInfo::LocationPhone < ApplicationRecord
  belongs_to :location, foreign_key: "location_info_location_id", class_name: 'LocationInfo::Location'
  belongs_to :phone, foreign_key: "contact_info_phone_id", class_name: 'ContactInfo::Phone'
  
  validates :location_info_location_id, presence: true
  validates :contact_info_phone_id, presence: true, uniqueness: {scope: :location_info_location_id}  
end
