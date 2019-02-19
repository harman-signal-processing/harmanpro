class ContactInfo::ContactProSiteOption < ApplicationRecord
  belongs_to :contact, foreign_key: "contact_info_contact_id"
  validates :contact_info_contact_id, presence: true
end
