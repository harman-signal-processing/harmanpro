class ContactInfo::ContactTerritory < ApplicationRecord
  belongs_to :contact, foreign_key: "contact_info_contact_id"
  belongs_to :territory, foreign_key: "contact_info_territory_id"

  validates :contact_info_contact_id, presence: true
  validates :contact_info_territory_id, presence: true, uniqueness: { scope: :contact_info_contact_id, case_sensitive: false }

end
