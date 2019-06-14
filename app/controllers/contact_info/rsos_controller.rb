class ContactInfo::RsosController < ApplicationController
  respond_to :json
  def index
  end    
  
  def show
    country_code = params[:country_code].nil? ? "us" : params[:country_code]
    territories = ContactInfo::Territory.joins(:supported_countries).where("location_info_countries.alpha2 = ?", country_code)
    rso_contacts = ContactInfo::Contact.joins(:territories).where("contact_info_contact_territories.contact_info_territory_id in(?)", territories.pluck(:id)).order("contact_info_contact_territories.position")
    
    respond_with rso_contacts.as_json(
      only: [:id,:name,:title],
      include: {
          emails: { only: [:id, :email, :label], methods: [:email_sort_order_for_contact]}, # contact emails
          phones: { only: [:id, :phone, :label], methods: [:phone_sort_order_for_contact]}, # contact phones
          websites: { only: [:id, :url, :label], methods: [:website_sort_order_for_contact]}, # contact websites
          data_clients: { only: [:id, :name]}     # contact data_clients
      }  # contacts include        
    )  #  respond_with rso_contacts.as_json
    
  end  #  def show
  
end  #  class ContactInfo::RSOsController < ApplicationController
