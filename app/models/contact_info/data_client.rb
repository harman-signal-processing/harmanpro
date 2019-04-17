class ContactInfo::DataClient < ApplicationRecord
  extend FriendlyId
  friendly_id :name 
  
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  
  has_many :data_client_to_contacts_association, dependent: :destroy, foreign_key: "contact_info_data_client_id", class_name: 'ContactInfo::ContactDataClient'
  has_many :contacts, -> { order 'contact_info_contact_data_clients.position' }, through: :data_client_to_contacts_association, source: :contact, class_name: 'ContactInfo::Contact'
  
  scope :not_associated_with_this_contact, ->(contact) { 
   data_client_ids_already_associated_with_this_contact = ContactInfo::ContactDataClient.where("contact_info_contact_id = ?", contact.id).map{|contact_data_client| contact_data_client.contact_info_data_client_id }
   data_clients_not_associated_with_this_contact = ContactInfo::DataClient.where.not(id: data_client_ids_already_associated_with_this_contact)    
   data_clients_not_associated_with_this_contact
  } 
  
end
