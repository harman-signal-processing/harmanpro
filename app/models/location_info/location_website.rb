class LocationInfo::LocationWebsite < ApplicationRecord
  belongs_to :location, foreign_key: "location_info_location_id", class_name: 'LocationInfo::Location'
  belongs_to :website, foreign_key: "contact_info_website_id", class_name: 'ContactInfo::Website'
  
  validates :location_info_location_id, presence: true
  validates :contact_info_website_id, presence: true, uniqueness: {scope: :location_info_location_id, case_sensitive: false}  
end
