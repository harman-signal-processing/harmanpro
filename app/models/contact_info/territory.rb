class ContactInfo::Territory < ApplicationRecord
  validates :name, presence: true
  
  has_many :territory_to_contacts_association, dependent: :destroy, foreign_key: "contact_info_territory_id", class_name: "ContactInfo::ContactTerritory"
  has_many :contacts, through: :territory_to_contacts_association, source: :contact, class_name: "ContactInfo::Contact"
end
