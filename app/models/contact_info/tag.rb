class ContactInfo::Tag < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  
  has_many :tag_to_contacts_association, dependent: :destroy, foreign_key: "contact_info_tag_id", class_name: 'ContactInfo::ContactTag'
  has_many :contacts, through: :tag_to_contacts_association, source: :contact, class_name: 'ContactInfo::Contact'
  
    scope :not_associated_with_this_contact, ->(contact) { 
    tag_ids_already_associated_with_this_contact = ContactInfo::ContactTag.where("contact_info_contact_id = ?", contact.id).map{|contact_tag| contact_tag.contact_info_tag_id }
    tags_not_associated_with_this_contact = ContactInfo::Tag.where.not(id: tag_ids_already_associated_with_this_contact)    
    tags_not_associated_with_this_contact
  }
  
end
