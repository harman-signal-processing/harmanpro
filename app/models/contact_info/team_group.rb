class ContactInfo::TeamGroup < ApplicationRecord
 extend FriendlyId
 friendly_id :name 
 
 validates :name, presence: true, uniqueness: { case_sensitive: false }
 
 has_many :team_group_to_contacts_association, dependent: :destroy, foreign_key: "contact_info_team_group_id", class_name: 'ContactInfo::ContactTeamGroup'
 has_many :contacts, through: :team_group_to_contacts_association, source: :contact, class_name: 'ContactInfo::Contact'
 
  scope :not_associated_with_this_contact, ->(contact) { 
   team_group_ids_already_associated_with_this_contact = ContactInfo::ContactTeamGroup.where("contact_info_contact_id = ?", contact.id).map{|contact_team_group| contact_team_group.contact_info_team_group_id }
   team_groups_not_associated_with_this_contact = ContactInfo::TeamGroup.where.not(id: team_group_ids_already_associated_with_this_contact)    
   team_groups_not_associated_with_this_contact
  } 
 
end
