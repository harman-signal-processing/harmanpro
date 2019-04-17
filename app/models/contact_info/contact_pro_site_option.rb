class ContactInfo::ContactProSiteOption < ApplicationRecord
  belongs_to :contact, foreign_key: "contact_info_contact_id", class_name: 'ContactInfo::Contact'
  validates :contact_info_contact_id, presence: true, uniqueness: {scope: :contact_info_contact_id}
end
