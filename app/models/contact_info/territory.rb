class ContactInfo::Territory < ApplicationRecord
  extend FriendlyId
  friendly_id :name 
 
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  
  has_many :territory_to_contacts_association, dependent: :destroy, foreign_key: "contact_info_territory_id", class_name: "ContactInfo::ContactTerritory"
  has_many :contacts, through: :territory_to_contacts_association, source: :contact, class_name: "ContactInfo::Contact"
  
  has_many :territory_to_countries_associaton, dependent: :destroy, foreign_key: "contact_info_territory_id", class_name: "ContactInfo::TerritorySupportedCountry"
  has_many :supported_countries, through: :territory_to_countries_associaton, source: :country, class_name: "LocationInfo::Country"
  
    scope :not_associated_with_this_contact, -> (contact) { 
    territories_not_associated_with_this_contact = ContactInfo::Territory.where.not(id: contact.territories.pluck(:id))    
    territories_not_associated_with_this_contact
  }
  
    scope :not_associated_with_this_country, -> (country) { 
    territories_not_associated_with_this_country = ContactInfo::Territory.where.not(id: country.supported_territories.pluck(:id))    
    territories_not_associated_with_this_country
  }  
  
end
