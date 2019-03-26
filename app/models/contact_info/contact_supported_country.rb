class ContactInfo::ContactSupportedCountry < ApplicationRecord
  belongs_to :contact, foreign_key: 'contact_info_contact_id', class_name: 'ContactInfo::Contact'
  belongs_to :country, foreign_key: 'location_info_country_id', class_name: 'LocationInfo::Country'  
  
  validates :contact_info_contact_id, presence: true
  validates :location_info_country_id, presence: true, uniqueness: {scope: :contact_info_contact_id}  
end
