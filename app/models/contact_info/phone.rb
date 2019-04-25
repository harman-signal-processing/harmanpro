class ContactInfo::Phone < ApplicationRecord
  extend FriendlyId
  friendly_id :phone
  
  validates :phone, presence: true, uniqueness: { case_sensitive: false }
  
  has_many :phone_to_contacts_association, dependent: :destroy, foreign_key: "contact_info_phone_id", class_name: 'ContactInfo::ContactPhone'
  has_many :contacts, through: :phone_to_contacts_association, source: :contact, class_name: 'ContactInfo::Contact'
  
  has_many :phone_to_distributors_association, dependent: :destroy, foreign_key: "contact_info_phone_id", class_name: 'DistributorInfo::DistributorPhone'
  has_many :distributors, through: :phone_to_distributors_association, source: :distributor, class_name: 'DistributorInfo::Distributor'  
    
  has_many :phone_to_locations_association, dependent: :destroy, foreign_key: "contact_info_phone_id", class_name: 'LocationInfo::LocationPhone'
  has_many :locations, through: :phone_to_locations_association, source: :location, class_name: 'LocationInfo::Location'  
  
  scope :not_associated_with_this_contact, -> (contact) { 
    phone_ids_already_associated_with_this_contact = ContactInfo::ContactPhone.where("contact_info_contact_id = ?", contact.id).map{|contact_phone| contact_phone.contact_info_phone_id }
    phones_not_associated_with_this_contact = ContactInfo::Phone.where.not(id: phone_ids_already_associated_with_this_contact)    
    phones_not_associated_with_this_contact
  }
  
  scope :not_associated_with_this_distributor, ->(distributor) { 
    phone_ids_already_associated_with_this_distributor = DistributorInfo::DistributorPhone.where("distributor_info_distributor_id = ?", distributor.id).map{|distributor_phone| distributor_phone.contact_info_phone_id }
    phones_not_associated_with_this_distributor = ContactInfo::Phone.where.not(id: phone_ids_already_associated_with_this_distributor)    
    phones_not_associated_with_this_distributor
  }  
  
  scope :not_associated_with_this_location, ->(location) { 
    phone_ids_already_associated_with_this_location = LocationInfo::LocationPhone.where("location_info_location_id = ?", location.id).map{|location_phone| location_phone.contact_info_phone_id }
    phones_not_associated_with_this_location = ContactInfo::Phone.where.not(id: phone_ids_already_associated_with_this_location)    
    phones_not_associated_with_this_location
  }  
  
  # The sort methods below currently only called from distributors.as_json in DistributorInfo::DistributorsController. 
  def phone_sort_order_for_contact
    phone_to_contacts_association.first.nil? ? 0 : phone_to_contacts_association.first.position.nil? ? 0 : phone_to_contacts_association.first.position
  end 
  
  def phone_sort_order_for_distributor
    phone_to_distributors_association.first.nil? ? 0 : phone_to_distributors_association.first.position.nil? ? 0 : phone_to_distributors_association.first.position
  end 
  
  def phone_sort_order_for_location
    phone_to_locations_association.first.nil? ? 0 : phone_to_locations_association.first.position.nil? ? 0 : phone_to_locations_association.first.position
  end   
  
end
