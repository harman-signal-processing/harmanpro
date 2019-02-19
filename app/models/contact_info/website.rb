class ContactInfo::Website < ApplicationRecord
  validates :url, presence: true
  
  has_many :website_to_contacts_association, dependent: :destroy, foreign_key: "contact_info_website_id", class_name: "ContactInfo::ContactWebsite"
  has_many :contacts, through: :website_to_contacts_association, source: :contact, class_name: 'ContactInfo::Website'
end
