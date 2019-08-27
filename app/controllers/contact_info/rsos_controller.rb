class ContactInfo::RsosController < ApplicationController
  respond_to :json
  def index
  end    
  
  def show
    country_code = params[:country_code].nil? ? "us" : clean_country_code(params[:country_code])
    territories = ContactInfo::Territory.joins(:supported_countries).where("location_info_countries.alpha2 = ?", country_code)
    rso_contacts = ContactInfo::Contact.joins(:territories).where("contact_info_contact_territories.contact_info_territory_id in(?)", territories.pluck(:id)).order("contact_info_contact_territories.position")
    rso_contacts_json = get_contacts_json(rso_contacts)
    filtered_rso_contacts_json = remove_contacts_not_matching_brandsites_rso_data_client(rso_contacts_json)
    respond_with filtered_rso_contacts_json
  end  #  def show
  
  private
  
  def get_contacts_json(contacts)
    contacts.as_json(
      only: [:id,:name,:title],
      include: {
          emails: { only: [:id, :email, :label], methods: [:email_sort_order_for_contact]}, # contact emails
          phones: { only: [:id, :phone, :label], methods: [:phone_sort_order_for_contact]}, # contact phones
          websites: { only: [:id, :url, :label], methods: [:website_sort_order_for_contact]}, # contact websites
          data_clients: { only: [:id, :name]}     # contact data_clients
      }  # contacts include        
    )  #  contacts.as_json
  end  #  def get_contacts_json(contacts)
  
  def remove_contacts_not_matching_brandsites_rso_data_client(contacts)
    filtered_rso_contacts = contacts.delete_if { |contact|
      !contact["data_clients"].select {|data_client| data_client["name"] == "brandsite/support/rsos"}.any? 
    }  #  contacts.delete_if {|contact|
        
    filtered_rso_contacts
  end  #  def remove_contacts_not_matching_brandsites_rso_data_client(contacts)  
  
end  #  class ContactInfo::RSOsController < ApplicationController
