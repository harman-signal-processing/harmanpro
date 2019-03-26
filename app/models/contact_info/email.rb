class ContactInfo::Email < ApplicationRecord
  validates :email, presence: true, uniqueness: { case_sensitive: false }
    
  has_many :email_to_contacts_association, dependent: :destroy, foreign_key: "contact_info_email_id", class_name: 'ContactInfo::ContactEmail'
  has_many :contacts, through: :email_to_contacts_association, source: :contact, class_name: 'ContactInfo::Contact'
  
  has_many :email_to_distributors_association, dependent: :destroy, foreign_key: "contact_info_email_id", class_name: 'DistributorInfo::DistributorEmail'
  has_many :distributors, through: :email_to_distributors_association, source: :distributor, class_name: 'DistributorInfo::Distributor'  
  
  has_many :email_to_locations_association, dependent: :destroy, foreign_key: "contact_info_email_id", class_name: 'LocationInfo::LocationEmail'
  has_many :locations, through: :email_to_locations_association, source: :location, class_name: 'LocationInfo::Location'  
    
  
  scope :not_associated_with_this_contact, ->(contact) { 
    email_ids_already_associated_with_this_contact = ContactInfo::ContactEmail.where("contact_info_contact_id = ?", contact.id).map{|contact_email| contact_email.contact_info_email_id }
    emails_not_associated_with_this_contact = ContactInfo::Email.where.not(id: email_ids_already_associated_with_this_contact)    
    emails_not_associated_with_this_contact
  }  
  
  scope :not_associated_with_this_distributor, ->(distributor) { 
    email_ids_already_associated_with_this_distributor = DistributorInfo::DistributorEmail.where("distributor_info_distributor_id = ?", distributor.id).map{|distributor_email| distributor_email.contact_info_email_id }
    emails_not_associated_with_this_distributor = ContactInfo::Email.where.not(id: email_ids_already_associated_with_this_distributor)    
    emails_not_associated_with_this_distributor
  }  
  
  scope :not_associated_with_this_location, ->(location) { 
    email_ids_already_associated_with_this_location = LocationInfo::LocationEmail.where("location_info_location_id = ?", location.id).map{|location_email| location_email.contact_info_email_id }
    emails_not_associated_with_this_location = ContactInfo::Email.where.not(id: email_ids_already_associated_with_this_location)    
    emails_not_associated_with_this_location
  }  
  
end
