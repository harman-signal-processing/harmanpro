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
        methods: :sort_order_for_brand
        )  #  distributors_json = distributors.as_json
        
    respond_with distributors_json

  end  #  def show
end  #  class DistributorInfo::DistributorsController < ApplicationController
