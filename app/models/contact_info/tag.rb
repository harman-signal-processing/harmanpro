class ContactInfo::Tag < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  
  has_many :tag_to_contacts_association, dependent: :destroy, foreign_key: "contact_info_tag_id", class_name: 'ContactInfo::ContactTag'
  has_many :contacts, through: :tag_to_contacts_association, source: :contact, class_name: 'ContactInfo::Contact'
end
