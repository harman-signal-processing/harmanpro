class DistributorInfo::DistributorsController < ApplicationController
  respond_to :json
  def index
  end
  
  def show
    brand = params[:brand].nil? ? "bss" : params[:brand]
    country_code = params[:country_code].nil? ? "us" : params[:country_code]
    
    distributors = DistributorInfo::Distributor.joins(:countries, :brands).where("location_info_countries.alpha2 = ? and brands.name = ?", country_code, brand)
    
    distributors_json = distributors.as_json(
        only: [:id,:name,:account_number], 
        include: { 
          locations: { 
            except: [:slug, :created_at, :updated_at],
            include: { 
              contacts: { only: [:id, :name, :title, :label], 
                include: {
                  emails: { only: [:id, :email, :label]},
                  phones: { only: [:id, :phone, :label]},
                  websites: { only: [:id, :url, :label]},
                  data_clients: { only: [:id, :name]}
                  }
                },  # location contact emails, phones, websites, data clients
              emails: { only: [:id, :email, :label]}, # location emails
              phones: { only: [:id, :phone, :label]}, # location phones
              websites: { only: [:id, :url, :label]}, # location websites              
              supported_countries: { only: [:id, :name, :harman_name, :alpha2, :world_region, :harman_world_region]},  # location supported countries
              supported_brands: { only: [:id, :name, :url]}  # location supported brands
              } # locations include
          }, # locations 
          emails: { only: [:id, :email, :label]}, # distributor emails
          phones: { only: [:id, :phone, :label]}, # distributor phones
          websites: { only: [:id, :url, :label]}, # distributor websites
          brands: { only: [:id, :name, :url]}, # distributor brands
          countries: { only: [:id, :name, :harman_name, :alpha2, :world_region, :harman_world_region]}
        },  #  distributors include
        methods: [:sort_order_for_brand, :sort_order_for_country]
        )  #  distributors_json = distributors.as_json
        
        distributors_and_locations_filtered_by_country_and_brand = distributors_json.each do |distributor|
          # removing locations that do not support country and brand
          distributor["locations"].delete_if{|location| 
            ((!location["supported_countries"].select {|country| country["alpha2"].downcase == country_code }.any?) && (!location["supported_brands"].select {|brand| brand["name"].downcase == brand }.any?))
          }  #  distributor.locations.delete_if{|location|
        end  #  distributors_and_locations_filtered_by_country_and_brand = distributors_json.each do |distributor|
        
    respond_with distributors_and_locations_filtered_by_country_and_brand
    # respond_with distributors_json

  end  #  def show
end  #  class DistributorInfo::DistributorsController < ApplicationController
