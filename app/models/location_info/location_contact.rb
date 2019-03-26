class LocationInfo::LocationContact < ApplicationRecord
  belongs_to :location, foreign_key: "location_info_location_id", class_name: 'LocationInfo::Location'
  belongs_to :contact, foreign_key: "contact_info_contact_id", class_name: 'ContactInfo::Contact'
  
  validates :location_info_location_id, presence: true
  validates :contact_info_contact_id, presence: true, uniqueness: {scope: :location_info_location_id}  
end
