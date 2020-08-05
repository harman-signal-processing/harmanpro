class ContactInfo::ContactTeamGroup < ApplicationRecord
  belongs_to :contact, foreign_key: "contact_info_contact_id"
  belongs_to :team_group, foreign_key: "contact_info_team_group_id"

  validates :contact_info_contact_id, presence: true
  validates :contact_info_team_group_id, presence: true, uniqueness: { scope: :contact_info_contact_id, case_sensitive: false }

end
