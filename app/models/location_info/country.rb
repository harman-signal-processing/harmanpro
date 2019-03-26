class LocationInfo::Country < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  
  # will likely be removing the distributor association because countries will now be associated to locations instead
  has_many :country_to_distributors_association, dependent: :destroy, foreign_key: 'location_info_country_id', class_name: 'DistributorInfo::DistributorCountry'
  has_many :distributors, through: :country_to_distributors_association, source: :distributor, class_name: 'DistributorInfo::Distributor'
  
  has_many :country_to_supported_locations_association, dependent: :destroy, foreign_key: 'location_info_country_id', class_name: 'LocationInfo::LocationSupportedCountry'
  has_many :supported_locations, through: :country_to_supported_locations_association, source: :location, class_name: 'LocationInfo::Location'  
  
  has_many :country_to_supported_contacts_association, dependent: :destroy, foreign_key: 'location_info_country_id', class_name: 'ContactInfo::ContactSupportedCountry'
  has_many :supported_contacts, through: :country_to_supported_contacts_association, source: :contact, class_name: 'ContactInfo::Contact'  
    
  
  scope :not_associated_with_this_distributor, ->(distributor) { 
    country_ids_already_associated_with_this_distributor = DistributorInfo::DistributorCountry.where("distributor_info_distributor_id = ?", distributor.id).map{|distributor_country| distributor_country.location_info_country_id }
    countries_not_associated_with_this_distributor = LocationInfo::Country.where.not(id: country_ids_already_associated_with_this_distributor).order(:name)    
    countries_not_associated_with_this_distributor
  }   
  
  scope :not_associated_with_this_location, ->(location) { 
    country_ids_already_associated_with_this_location = LocationInfo::LocationSupportedCountry.where("location_info_location_id = ?", location.id).map{|location_supported_country| location_supported_country.location_info_country_id }
    countries_not_associated_with_this_location = LocationInfo::Country.where.not(id: country_ids_already_associated_with_this_location).order(:name)    
    countries_not_associated_with_this_location
  }  
  
  scope :not_associated_with_this_contact, ->(contact) { 
    country_ids_already_associated_with_this_contact = ContactInfo::ContactSupportedCountry.where("contact_info_contact_id = ?", contact.id).map{|contact_supported_country| contact_supported_country.location_info_country_id }
    countries_not_associated_with_this_contact = LocationInfo::Country.where.not(id: country_ids_already_associated_with_this_contact).order(:name)    
    countries_not_associated_with_this_contact
  }   
  
  scope :long_name, ->(alpha2_code) {
    country = LocationInfo::Country.where(alpha2: alpha2_code)
    country.first.name
  }
  
end  #  class LocationInfo::Country < ApplicationRecord
