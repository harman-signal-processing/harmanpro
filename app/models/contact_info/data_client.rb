class ContactInfo::DataClient < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  
  has_many :data_client_to_contacts_association, dependent: :destroy, foreign_key: "contact_info_data_client_id", class_name: 'ContactInfo::ContactDataClient'
  has_many :contacts, -> { order 'contact_info_contact_data_clients.position' }, through: :data_client_to_contacts_association, source: :contact, class_name: 'ContactInfo::Contact'
end
