class ContactInfo::ContactPhone < ApplicationRecord
  belongs_to :contact, foreign_key: "contact_info_contact_id"
  belongs_to :phone, foreign_key: "contact_info_phone_id"
  
  validates :contact_info_contact_id, presence: true
  validates :contact_info_phone_id, presence: true, uniqueness: {scope: :contact_info_contact_id}
end
