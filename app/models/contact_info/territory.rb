class ContactInfo::Territory < ApplicationRecord
  extend FriendlyId
  friendly_id :name 
 
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  
  has_many :territory_to_contacts_association, dependent: :destroy, foreign_key: "contact_info_territory_id", class_name: "ContactInfo::ContactTerritory"
  has_many :contacts, through: :territory_to_contacts_association, source: :contact, class_name: "ContactInfo::Contact"
  
    scope :not_associated_with_this_contact, -> (contact) { 
    territory_ids_already_associated_with_this_contact = ContactInfo::ContactTerritory.where("contact_info_contact_id = ?", contact.id).map{|contact_territory| contact_territory.contact_info_territory_id }
    territories_not_associated_with_this_contact = ContactInfo::Territory.where.not(id: territory_ids_already_associated_with_this_contact)    
    territories_not_associated_with_this_contact
  }
  
end
