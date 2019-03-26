class DistributorInfo::Distributor < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  
  has_many :distributor_to_brands_association, dependent: :destroy, foreign_key: 'distributor_info_distributor_id', class_name: 'DistributorInfo::DistributorBrand'
  has_many :brands, through: :distributor_to_brands_association, source: :brand, class_name: 'Brand'
  
  has_many :distributor_to_locations_association, dependent: :destroy, foreign_key: 'distributor_info_distributor_id', class_name: 'DistributorInfo::DistributorLocation'
  has_many :locations, through: :distributor_to_locations_association, source: :location, class_name: 'LocationInfo::Location'
  
  has_many :distributor_to_contacts_association, dependent: :destroy, foreign_key: 'distributor_info_distributor_id', class_name: 'DistributorInfo::DistributorContact'
  has_many :contacts, through: :distributor_to_contacts_association, source: :contact, class_name: 'ContactInfo::Contact'  
  
  has_many :distributor_to_emails_association, dependent: :destroy, foreign_key: 'distributor_info_distributor_id', class_name: 'DistributorInfo::DistributorEmail'
  has_many :emails, through: :distributor_to_emails_association, source: :email, class_name: 'ContactInfo::Email'    
  
  has_many :distributor_to_phones_association, dependent: :destroy, foreign_key: 'distributor_info_distributor_id', class_name: 'DistributorInfo::DistributorPhone'
  has_many :phones, through: :distributor_to_phones_association, source: :phone, class_name: 'ContactInfo::Phone'    
  
  has_many :distributor_to_websites_association, dependent: :destroy, foreign_key: 'distributor_info_distributor_id', class_name: 'DistributorInfo::DistributorWebsite'
  has_many :websites, through: :distributor_to_websites_association, source: :website, class_name: 'ContactInfo::Website'    
  
  has_many :distributor_to_countries_association, dependent: :destroy, foreign_key: 'distributor_info_distributor_id', class_name: 'DistributorInfo::DistributorCountry'
  has_many :countries, through: :distributor_to_countries_association, source: :country, class_name: 'LocationInfo::Country'    
  
  scope :not_associated_with_this_country, ->(country) { 
    distributor_ids_already_associated_with_this_country = DistributorInfo::DistributorCountry.where("location_info_country_id = ?", country.id).map{|distributor_country| distributor_country.distributor_info_distributor_id }
    distributors_not_associated_with_this_country = DistributorInfo::Distributor.where.not(id: distributor_ids_already_associated_with_this_country).order(:name)    
    distributors_not_associated_with_this_country
  }  
  
  scope :not_associated_with_this_contact, ->(contact) { 
    distributor_ids_already_associated_with_this_contact = DistributorInfo::DistributorContact.where("contact_info_contact_id = ?", contact.id).map{|distributor_contact| distributor_contact.distributor_info_distributor_id }
    distributors_not_associated_with_this_contact = DistributorInfo::Distributor.where.not(id: distributor_ids_already_associated_with_this_contact).order(:name)    
    distributors_not_associated_with_this_contact
  }  
  
  scope :not_associated_with_this_location, ->(location) { 
    distributor_ids_already_associated_with_this_location = DistributorInfo::DistributorLocation.where("location_info_location_id = ?", location.id).map{|distributor_location| distributor_location.distributor_info_distributor_id }
    distributors_not_associated_with_this_location = DistributorInfo::Distributor.where.not(id: distributor_ids_already_associated_with_this_location).order(:name)    
    distributors_not_associated_with_this_location
  }  
  
  scope :not_associated_with_this_email, ->(email) { 
    distributor_ids_already_associated_with_this_email = DistributorInfo::DistributorEmail.where("contact_info_email_id = ?", email.id).map{|distributor_email| distributor_email.distributor_info_distributor_id }
    distributors_not_associated_with_this_email = DistributorInfo::Distributor.where.not(id: distributor_ids_already_associated_with_this_email).order(:name)    
    distributors_not_associated_with_this_email
  }  
  
  scope :not_associated_with_this_phone, ->(phone) { 
    distributor_ids_already_associated_with_this_phone = DistributorInfo::DistributorPhone.where("contact_info_phone_id = ?", phone.id).map{|distributor_phone| distributor_phone.distributor_info_distributor_id }
    distributors_not_associated_with_this_phone = DistributorInfo::Distributor.where.not(id: distributor_ids_already_associated_with_this_phone).order(:name)    
    distributors_not_associated_with_this_phone
  }  
  
  scope :not_associated_with_this_website, ->(website) { 
    distributor_ids_already_associated_with_this_website = DistributorInfo::DistributorWebsite.where("contact_info_website_id = ?", website.id).map{|distributor_website| distributor_website.distributor_info_distributor_id }
    distributors_not_associated_with_this_website = DistributorInfo::Distributor.where.not(id: distributor_ids_already_associated_with_this_website).order(:name)    
    distributors_not_associated_with_this_website
  }   
  
end
