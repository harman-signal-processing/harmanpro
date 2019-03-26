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

  # may be removing this contact_to_distributors_association because we are now associating contacts to locations instead
  has_many :contact_to_distributors_association, dependent: :destroy, foreign_key: "contact_info_contact_id", class_name: 'DistributorInfo::DistributorContact'
  has_many :distributors, through: :contact_to_distributors_association, source: :distributor, class_name: 'DistributorInfo::Distributor'
  
  has_many :contact_to_supported_brands_association, dependent: :destroy, foreign_key: 'contact_info_contact_id', class_name: 'ContactInfo::ContactSupportedBrand'
  has_many :supported_brands, through: :contact_to_supported_brands_association, source: :brand, class_name: 'Brand'  
    
  has_many :contact_to_supported_countries_association, dependent: :destroy, foreign_key: 'contact_info_contact_id', class_name: 'ContactInfo::ContactSupportedCountry'
  has_many :supported_countries, through: :contact_to_supported_countries_association, source: :country, class_name: 'LocationInfo::Country'  
    

  scope :not_associated_with_this_phone, ->(phone) { 
    contact_ids_already_associated_with_this_phone = ContactInfo::ContactPhone.where("contact_info_phone_id = ?", phone.id).map{|contact_phone| contact_phone.contact_info_contact_id }
    contacts_not_associated_with_this_phone = ContactInfo::Contact.where.not(id: contact_ids_already_associated_with_this_phone).order(:name)    
    contacts_not_associated_with_this_phone
  }

  scope :not_associated_with_this_email, ->(email) { 
    contact_ids_already_associated_with_this_email = ContactInfo::ContactEmail.where("contact_info_email_id = ?", email.id).map{|contact_email| contact_email.contact_info_contact_id }
    contacts_not_associated_with_this_email = ContactInfo::Contact.where.not(id: contact_ids_already_associated_with_this_email).order(:name)    
    contacts_not_associated_with_this_email
  }

  scope :not_associated_with_this_website, ->(website) { 
    contact_ids_already_associated_with_this_website = ContactInfo::ContactWebsite.where("contact_info_website_id = ?", website.id).map{|contact_website| contact_website.contact_info_contact_id }
    contacts_not_associated_with_this_website = ContactInfo::Contact.where.not(id: contact_ids_already_associated_with_this_website).order(:name)    
    contacts_not_associated_with_this_website
  }

  scope :not_associated_with_this_team_group, ->(team_group) { 
    contact_ids_already_associated_with_this_team_group = ContactInfo::ContactTeamGroup.where("contact_info_team_group_id = ?", team_group.id).map{|contact_team_group| contact_team_group.contact_info_contact_id }
    contacts_not_associated_with_this_team_group = ContactInfo::Contact.where.not(id: contact_ids_already_associated_with_this_team_group).order(:name)    
    contacts_not_associated_with_this_team_group
  }

  scope :not_associated_with_this_territory, ->(territory) { 
    contact_ids_already_associated_with_this_territory = ContactInfo::ContactTerritory.where("contact_info_territory_id = ?", territory.id).map{|contact_territory| contact_territory.contact_info_contact_id }
    contacts_not_associated_with_this_territory = ContactInfo::Contact.where.not(id: contact_ids_already_associated_with_this_territory).order(:name)    
    contacts_not_associated_with_this_territory
  }
  
  scope :not_associated_with_this_tag, ->(tag) { 
    contact_ids_already_associated_with_this_tag = ContactInfo::ContactTag.where("contact_info_tag_id = ?", tag.id).map{|contact_tag| contact_tag.contact_info_contact_id }
    contacts_not_associated_with_this_tag = ContactInfo::Contact.where.not(id: contact_ids_already_associated_with_this_tag).order(:name)    
    contacts_not_associated_with_this_tag
  }
  
  scope :not_associated_with_this_data_client, ->(data_client) { 
    contact_ids_already_associated_with_this_data_client = ContactInfo::ContactDataClient.where("contact_info_data_client_id = ?", data_client.id).map{|contact_data_client| contact_data_client.contact_info_contact_id }
    contacts_not_associated_with_this_data_client = ContactInfo::Contact.where.not(id: contact_ids_already_associated_with_this_data_client).order(:name)    
    contacts_not_associated_with_this_data_client
  }  
  
  scope :without_pro_site_option, ->() {
      contact_ids_of_all_pro_site_option_records = ContactInfo::ContactProSiteOption.all.map{|pro_site_option| pro_site_option.contact_info_contact_id }
      contacts_without_prosite_option_records = ContactInfo::Contact.where.not(id: contact_ids_of_all_pro_site_option_records).order(:name)    
      contacts_without_prosite_option_records
  }
  
  scope :not_associated_with_this_location, ->(location) { 
    contact_ids_already_associated_with_this_location = LocationInfo::LocationContact.where("location_info_location_id = ?", location.id).map{|location_contact| location_contact.contact_info_contact_id }
    contacts_not_associated_with_this_location = ContactInfo::Contact.where.not(id: contact_ids_already_associated_with_this_location).order(:name)    
    contacts_not_associated_with_this_location
  }  
  
  scope :not_associated_with_this_distributor, ->(distributor) { 
    contact_ids_already_associated_with_this_distributor = DistributorInfo::DistributorContact.where("distributor_info_distributor_id = ?", distributor.id).map{|distributor_contact| distributor_contact.contact_info_contact_id }
    contacts_not_associated_with_this_distributor = ContactInfo::Contact.where.not(id: contact_ids_already_associated_with_this_distributor).order(:name)    
    contacts_not_associated_with_this_distributor
  }   
  
  scope :not_associated_with_this_brand, ->(brand) { 
    contact_ids_already_associated_with_this_brand = ContactInfo::ContactSupportedBrand.where("brand_id = ?", brand.id).map{|contact_supported_brand| contact_supported_brand.contact_info_contact_id }
    contacts_not_associated_with_this_brand = ContactInfo::Contact.where.not(id: contact_ids_already_associated_with_this_brand).order(:name)    
    contacts_not_associated_with_this_brand
  }  
  
  scope :not_associated_with_this_country, ->(country) { 
    contact_ids_already_associated_with_this_country = ContactInfo::ContactSupportedCountry.where("country_id = ?", country.id).map{|contact_supported_country| contact_supported_country.contact_info_contact_id }
    contacts_not_associated_with_this_country = ContactInfo::Contact.where.not(id: contact_ids_already_associated_with_this_country).order(:name)    
    contacts_not_associated_with_this_country
  }  
  
end  #  class ContactInfo::Contact < ApplicationRecord
