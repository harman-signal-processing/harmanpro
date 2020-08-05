class LocationInfo::LocationEmail < ApplicationRecord
  belongs_to :location, foreign_key: "location_info_location_id", class_name: 'LocationInfo::Location'
  belongs_to :email, foreign_key: "contact_info_email_id", class_name: 'ContactInfo::Email'
  
  validates :location_info_location_id, presence: true
  validates :contact_info_email_id, presence: true, uniqueness: {scope: :location_info_location_id, case_sensitive: false}  
end
