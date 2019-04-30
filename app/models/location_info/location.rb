class LocationInfo::Location < ApplicationRecord
  extend FriendlyId
  friendly_id :name
  
  validates :name, presence: true
  validates :address1, presence: true
  validates :city, presence: true
  validates :country, presence: true
  
  has_many :location_to_contacts_association, dependent: :destroy, foreign_key: 'location_info_location_id', class_name: 'LocationInfo::LocationContact'
  has_many :contacts, -> { order 'location_info_location_contacts.position' }, through: :location_to_contacts_association, source: :contact, class_name: 'ContactInfo::Contact'  
  
  has_many :location_to_emails_association, dependent: :destroy, foreign_key: 'location_info_location_id', class_name: 'LocationInfo::LocationEmail'
  has_many :emails, -> { order 'location_info_location_emails.position' }, through: :location_to_emails_association, source: :email, class_name: 'ContactInfo::Email'  
  
  has_many :location_to_phones_association, dependent: :destroy, foreign_key: 'location_info_location_id', class_name: 'LocationInfo::LocationPhone'
  has_many :phones, -> { order 'location_info_location_phones.position' }, through: :location_to_phones_association, source: :phone, class_name: 'ContactInfo::Phone'  
  
  has_many :location_to_websites_association, dependent: :destroy, foreign_key: 'location_info_location_id', class_name: 'LocationInfo::LocationWebsite'
  has_many :websites, -> { order 'location_info_location_websites.position' }, through: :location_to_websites_association, source: :website, class_name: 'ContactInfo::Website'  
  
  has_many :location_to_regions_association, dependent: :destroy, foreign_key: 'location_info_location_id', class_name: 'LocationInfo::LocationRegion'
  has_many :regions, through: :location_to_regions_association, source: :region, class_name: 'LocationInfo::Region'
  
  has_many :location_to_distributors_association, dependent: :destroy, foreign_key: 'location_info_location_id', class_name: 'DistributorInfo::DistributorLocation'
  has_many :distributors, through: :location_to_distributors_association, source: :distributor, class_name: 'DistributorInfo::Distributor'  
  
  has_many :location_to_supported_countries_association, dependent: :destroy, foreign_key: 'location_info_location_id', class_name: 'LocationInfo::LocationSupportedCountry'
  has_many :supported_countries, through: :location_to_supported_countries_association, source: :country, class_name: 'LocationInfo::Country'  
  
  has_many :location_to_supported_brands_association, dependent: :destroy, foreign_key: 'location_info_location_id', class_name: 'LocationInfo::LocationSupportedBrand'
  has_many :supported_brands, through: :location_to_supported_brands_association, source: :brand, class_name: 'Brand'  
    
  
  scope :not_associated_with_this_contact, ->(contact) { 
    location_ids_already_associated_with_this_contact = LocationInfo::LocationContact.where("contact_info_contact_id = ?", contact.id).map{|contact_location| contact_location.location_info_location_id }
    locations_not_associated_with_this_contact = LocationInfo::Location.where.not(id: location_ids_already_associated_with_this_contact).order(:name)    
    locations_not_associated_with_this_contact
  }  
  
  scope :not_associated_with_this_email, ->(email) { 
    location_ids_already_associated_with_this_email = LocationInfo::LocationEmail.where("contact_info_email_id = ?", email.id).map{|email_location| email_location.location_info_location_id }
    locations_not_associated_with_this_email = LocationInfo::Location.where.not(id: location_ids_already_associated_with_this_email).order(:name)    
    locations_not_associated_with_this_email
  }  
  
  scope :not_associated_with_this_phone, ->(phone) { 
    location_ids_already_associated_with_this_phone = LocationInfo::LocationPhone.where("contact_info_phone_id = ?", phone.id).map{|phone_location| phone_location.location_info_location_id }
    locations_not_associated_with_this_phone = LocationInfo::Location.where.not(id: location_ids_already_associated_with_this_phone).order(:name)    
    locations_not_associated_with_this_phone
  }  
  
  scope :not_associated_with_this_website, ->(website) { 
    location_ids_already_associated_with_this_website = LocationInfo::LocationWebsite.where("contact_info_website_id = ?", website.id).map{|website_location| website_location.location_info_location_id }
    locations_not_associated_with_this_website = LocationInfo::Location.where.not(id: location_ids_already_associated_with_this_website).order(:name)    
    locations_not_associated_with_this_website
  }  
  
  scope :not_associated_with_this_distributor, ->(distributor) { 
    location_ids_already_associated_with_this_distributor = DistributorInfo::DistributorLocation.where("distributor_info_distributor_id = ?", distributor.id).map{|distributor_location| distributor_location.location_info_location_id }
    locations_not_associated_with_this_distributor = LocationInfo::Location.where.not(id: location_ids_already_associated_with_this_distributor).order(:name)    
    locations_not_associated_with_this_distributor
  }  
  
  scope :not_associated_with_this_region, ->(region) { 
    location_ids_already_associated_with_this_region = LocationInfo::LocationRegion.where("location_info_region_id = ?", region.id).map{|location_region| location_region.location_info_location_id }
    locations_not_associated_with_this_region = LocationInfo::Location.where.not(id: location_ids_already_associated_with_this_region).order(:name)    
    locations_not_associated_with_this_region
  }  
  
  scope :not_associated_with_this_country, ->(country) { 
    location_ids_already_associated_with_this_country = LocationInfo::LocationSupportedCountry.where("location_info_country_id = ?", country.id).map{|location_supported_country| location_supported_country.location_info_location_id }
    locations_not_associated_with_this_country = LocationInfo::Location.where.not(id: location_ids_already_associated_with_this_country).order(:name)    
    locations_not_associated_with_this_country
  }  
  
  scope :not_associated_with_this_brand, ->(brand) { 
    location_ids_already_associated_with_this_brand = LocationInfo::LocationSupportedBrand.where("brand_id = ?", brand.id).map{|location_supported_brand| location_supported_brand.location_info_location_id }
    locations_not_associated_with_this_brand = LocationInfo::Location.where.not(id: location_ids_already_associated_with_this_brand).order(:name)    
    locations_not_associated_with_this_brand
  }  
  
end  #  class LocationInfo::Location < ApplicationRecord
