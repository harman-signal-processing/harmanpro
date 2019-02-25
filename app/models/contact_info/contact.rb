class ContactInfo::Contact < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  
  has_many :contact_to_locations_association, dependent: :destroy, foreign_key: "contact_info_contact_id", class_name: 'LocationInfo::LocationContact'
  has_many :locations, -> { order 'location_info_location_contacts.position' }, through: :contact_to_locations_association, source: :location, class_name: 'LocationInfo::Location'
  
  has_many :contact_to_team_groups_association, dependent: :destroy, foreign_key: "contact_info_contact_id", class_name: 'ContactInfo::ContactTeamGroup'
  has_many :team_groups, -> { order 'contact_info_contact_team_groups.position' }, through: :contact_to_team_groups_association, source: :team_group, class_name: 'ContactInfo::TeamGroup'
  
  has_many :contact_to_territories_association, dependent: :destroy, foreign_key: "contact_info_contact_id", class_name: 'ContactInfo::ContactTerritory'
  has_many :territories, -> { order 'contact_info_contact_territories.position' }, through: :contact_to_territories_association, source: :territory, class_name: 'ContactInfo::Territory'

  has_many :contact_to_emails_association, dependent: :destroy, foreign_key: "contact_info_contact_id" , class_name: 'ContactInfo::ContactEmail'
  has_many :emails, -> { order 'contact_info_contact_emails.position' }, through: :contact_to_emails_association, source: :email, class_name: 'ContactInfo::Email'

  has_many :contact_to_phones_association, dependent: :destroy, foreign_key: "contact_info_contact_id", class_name: 'ContactInfo::ContactPhone'
  has_many :phones, -> { order 'contact_info_contact_phones.position' }, through: :contact_to_phones_association, source: :phone, class_name: 'ContactInfo::Phone'
  
  has_many :contact_to_data_clients_association, dependent: :destroy, foreign_key: "contact_info_contact_id", class_name: 'ContactInfo::ContactDataClient'
  has_many :data_clients, -> { order 'contact_info_contact_data_clients.position' }, through: :contact_to_data_clients_association, source: :data_client, class_name: 'ContactInfo::DataClient'
  
  has_many :contact_to_websites_association, dependent: :destroy, foreign_key: "contact_info_contact_id", class_name: 'ContactInfo::ContactWebsite'
  has_many :websites, -> { order 'contact_info_contact_websites.position' }, through: :contact_to_websites_association, source: :website, class_name: 'ContactInfo::Website'

  has_many :contact_to_tags_association, dependent: :destroy, foreign_key: "contact_info_contact_id", class_name: 'ContactInfo::ContactTag'
  has_many :tags, -> { order 'contact_info_contact_tags.position' }, through: :contact_to_tags_association, source: :tag, class_name: 'ContactInfo::Tag'
  
  has_one :pro_site_options, dependent: :destroy, foreign_key: "contact_info_contact_id", class_name: 'ContactInfo::ContactProSiteOption'

end
