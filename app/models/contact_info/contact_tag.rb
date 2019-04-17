class ContactInfo::ContactTag < ApplicationRecord
  belongs_to :contact, foreign_key: "contact_info_contact_id"
  belongs_to :tag, foreign_key: "contact_info_tag_id"
  
  validates :contact_info_contact_id, presence: true
  validates :contact_info_tag_id, presence: true, uniqueness: {scope: :contact_info_contact_id }
end
