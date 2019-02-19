class ContactInfo::Tag < ApplicationRecord
  validates :name, presence: true
  
  has_many :tag_to_contacts_association, dependent: :destroy, foreign_key: "contact_info_tag_id", class_name: 'ContactInfo::ContactTag'
  has_many :contacts, through: :tag_to_contacts_association, source: :tag, class_name: 'ContactInfo::Tag'
end
