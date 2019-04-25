class ContactInfo::Website < ApplicationRecord
  extend FriendlyId
  friendly_id :url
  
  validates :url, presence: true, uniqueness: { case_sensitive: false }
  
  has_many :website_to_contacts_association, dependent: :destroy, foreign_key: "contact_info_website_id", class_name: "ContactInfo::ContactWebsite"
  has_many :contacts, through: :website_to_contacts_association, source: :contact, class_name: 'ContactInfo::Contact'
  
  has_many :website_to_distributors_association, dependent: :destroy, foreign_key: "contact_info_website_id", class_name: 'DistributorInfo::DistributorWebsite'
  has_many :distributors, through: :website_to_distributors_association, source: :distributor, class_name: 'DistributorInfo::Distributor'  
     
  has_many :website_to_locations_association, dependent: :destroy, foreign_key: "contact_info_website_id", class_name: 'LocationInfo::LocationWebsite'
  has_many :locations, through: :website_to_locations_association, source: :location, class_name: 'LocationInfo::Location'  
     
  scope :not_associated_with_this_contact, -> (contact) { 
    website_ids_already_associated_with_this_contact = ContactInfo::ContactWebsite.where("contact_info_contact_id = ?", contact.id).map{|contact_website| contact_website.contact_info_website_id }
    websites_not_associated_with_this_contact = ContactInfo::Website.where.not(id: website_ids_already_associated_with_this_contact)    
    websites_not_associated_with_this_contact
  }
  
  scope :not_associated_with_this_distributor, ->(distributor) { 
    website_ids_already_associated_with_this_distributor = DistributorInfo::DistributorWebsite.where("distributor_info_distributor_id = ?", distributor.id).map{|distributor_website| distributor_website.contact_info_website_id }
    websites_not_associated_with_this_distributor = ContactInfo::Website.where.not(id: website_ids_already_associated_with_this_distributor)    
    websites_not_associated_with_this_distributor
  }  
  
  scope :not_associated_with_this_location, ->(location) { 
    website_ids_already_associated_with_this_location = LocationInfo::LocationWebsite.where("location_info_location_id = ?", location.id).map{|location_website| location_website.contact_info_website_id }
    websites_not_associated_with_this_location = ContactInfo::Website.where.not(id: website_ids_already_associated_with_this_location)    
    websites_not_associated_with_this_location
  }  
  
  # The sort methods below currently only called from distributors.as_json in DistributorInfo::DistributorsController. 
  def website_sort_order_for_contact
    website_to_contacts_association.first.nil? ? 0 : website_to_contacts_association.first.position.nil? ? 0 : website_to_contacts_association.first.position
  end 
  
  def website_sort_order_for_distributor
    website_to_distributors_association.first.nil? ? 0 : website_to_distributors_association.first.position.nil? ? 0 : website_to_distributors_association.first.position
  end   
  
  def website_sort_order_for_location
    website_to_locations_association.first.nil? ? 0 : website_to_locations_association.first.position.nil? ? 0 : website_to_locations_association.first.position
  end   
  
end
