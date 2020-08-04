class ContactInfo::ContactDataClient < ApplicationRecord
  belongs_to :contact, foreign_key: "contact_info_contact_id"
  belongs_to :data_client, foreign_key: "contact_info_data_client_id"

  validates :contact_info_contact_id, presence: true
  validates :contact_info_data_client_id, presence: true, uniqueness: { scope: :contact_info_contact_id, case_sensitive: false }

end
