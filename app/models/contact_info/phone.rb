class ContactInfo::Phone < ApplicationRecord
  validates :phone, presence: true, uniqueness: { case_sensitive: false }
  
  has_many :phone_to_contacts_association, dependent: :destroy, foreign_key: "contact_info_phone_id", class_name: 'ContactInfo::ContactPhone'
  has_many :contacts, through: :phone_to_contacts_association, source: :contact, class_name: 'ContactInfo::Contact'
  
end
