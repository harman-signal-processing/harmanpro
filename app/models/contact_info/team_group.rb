class ContactInfo::TeamGroup < ApplicationRecord
 validates :name, presence: true
 
 has_many :team_group_to_contacts_association, dependent: :destroy, foreign_key: "contact_info_team_group_id", class_name: 'ContactInfo::ContactTeamGroup'
 has_many :contacts, through: :team_group_to_contacts_association, source: :contact, class_name: 'ContactInfo::Contact'
 
end
