class DistributorInfo::DistributorsController < ApplicationController
  respond_to :json
  def index
  end
  
  def show
    brand = params[:brand].nil? ? "bss" : params[:brand]
    country_code = params[:country_code].nil? ? "us" : params[:country_code]
    
    distributors = DistributorInfo::Distributor.joins(:countries, :brands).where("location_info_countries.alpha2 = ? and brands.name = ?", country_code, brand)
    
    distributor_tree_unfiltered_json = get_complete_distributor_tree_json(distributors)
        
    distributors_tree_with_locations_filtered_by_country_and_brand_json = filter_distributor_locations_by_brand_and_country(distributor_tree_unfiltered_json, brand, country_code)
    
    distributors_json = filter_contacts(distributors_tree_with_locations_filtered_by_country_and_brand_json)
        
    respond_with distributors_json

  end  #  def show
  
  private
  
  def get_complete_distributor_tree_json (distributors)
    distributors_json = distributors.as_json(
      only: [:id,:name,:account_number], # distributor attributes to return
      include: { 
          locations: { 
              except: [:slug, :created_at, :updated_at],
              include: { 
                  contacts: { only: [:id, :name, :title, :label], 
                      include: {
                          emails: { only: [:id, :email, :label], methods: [:email_sort_order_for_contact]}, # contact emails
                          phones: { only: [:id, :phone, :label], methods: [:phone_sort_order_for_contact]}, # contact phones
                          websites: { only: [:id, :url, :label], methods: [:website_sort_order_for_contact]}, # contact websites
                          data_clients: { only: [:id, :name]}     # contact data_clients
                      },  # contacts include 
                      methods: [:contact_sort_order_for_location]  # location contacts sort order
                  },  # contacts
                  emails: { only: [:id, :email, :label], methods: [:email_sort_order_for_location]}, # location emails
                  phones: { only: [:id, :phone, :label], methods: [:phone_sort_order_for_location]}, # location phones
                  websites: { only: [:id, :url, :label], methods: [:website_sort_order_for_distributor]}, # location websites              
                  supported_countries: { only: [:id, :name, :harman_name, :alpha2, :world_region, :harman_world_region]},  # location supported countries
                  supported_brands: { only: [:id, :name, :url]}  # location supported brands
              }, # locations include
              methods: [:location_sort_order_for_distributor], # distributor location sort order
          }, # locations 
          emails: { only: [:id, :email, :label], methods: [:email_sort_order_for_distributor]}, # distributor emails
          phones: { only: [:id, :phone, :label], methods: [:phone_sort_order_for_distributor]}, # distributor phones
          websites: { only: [:id, :url, :label], methods: [:website_sort_order_for_location]}, # distributor websites
          brands: { only: [:id, :name, :url]}, # distributor brands
          countries: { only: [:id, :name, :harman_name, :alpha2, :world_region, :harman_world_region]} # distributor supported countries
      },  #  distributors include
      methods: [:sort_order_for_brand, :sort_order_for_country] # brand, country distributor sort order
    )  #  distributors_json = distributors.as_json
    
    distributors_json
  end  #  get_complete_distributor_tree_json (distributors)
  
  def filter_distributor_locations_by_brand_and_country(distributors, brand, country_code)
    distributors_and_locations_filtered_by_country_and_brand = distributors.each do |distributor|
      # removing locations that do not support country and brand
      distributor["locations"].delete_if{|location| 
        ((!location["supported_countries"].select {|country| country["alpha2"].downcase == country_code }.any?) && (!location["supported_brands"].select {|brand| brand["name"].downcase == brand }.any?))
      }  #  distributor.locations.delete_if{|location|
    end  #  distributors_and_locations_filtered_by_country_and_brand = distributors.each do |distributor|  
  
    distributors_and_locations_filtered_by_country_and_brand
  end  #  def filter_distributor_locations_by_brand_and_country(distributors)
  
  def filter_contacts(distributors)
      distributors_with_filtered_contacts = distributors.each do |distributor| 
        distributor["locations"].each do |location|
          location["contacts"].delete_if {|contact|
            !contact["data_clients"].select {|data_client|
              data_client["name"] == "brandsite/distributors"
            }.any?  #  !contact["data_clients"].select {|data_client|
          }  #  location["contacts"].delete_if {|contact|
        end  #  distributor["locations"].each do |location|
      end  #  distributors_with_filtered_contacts = distributors.each do |distributor|   
        
    distributors_with_filtered_contacts
  end  #  def filter_contacts(distributors)

end  #  class DistributorInfo::DistributorsController < ApplicationController
