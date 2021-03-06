class DistributorInfo::DistributorsController < ApplicationController

  ##### Actions #####
  def index
  end
  
  def show
    brand = params[:brand].blank? ? "bss" : params[:brand]
    country_code = params[:country_code].blank? ? "us" : clean_country_code(params[:country_code])
    
    @distributors_json = get_distributors_json(brand, country_code)
    render_distributors_json
  end  #  show
  
  def region
    brand = params[:brand].blank? ? "bss" : params[:brand]
    region = params[:region]
    country_code_list = country_codes_in_region(region) if region.present?
    distributors_json = []
    country_code_list.each do |country_code|
      distributors = get_distributors_json(brand, country_code)
      distributors_json += distributors if distributors.present?
    end
    @brand = brand
    @region = region
    @distributors_json = distributors_json
    render_distributors_json
  end  #  region
  
  def country_and_region
    brand = params[:brand].blank? ? "bss" : params[:brand]
    country_code = params[:country_code].blank? ? "us" : clean_country_code(params[:country_code])    
    region = params[:region]
    country_code_list = country_codes_in_region(region) if region.present?
    
    # Make sure the country specified is first in the country_code_list
    if country_code_list.include? country_code
      country_code_list.unshift(country_code_list.delete(country_code))
    else
      country_code_list.unshift(country_code)
    end
    
    distributors_json = []
    country_code_list.each do |alpha2|
      distributors = get_distributors_json(brand, alpha2)
      distributors_json += distributors if distributors.present?
    end
    @brand = brand
    @region = region
    @country_code = country_code
    @distributors_json = distributors_json
    render_distributors_json
    
  end  #  country_and_region
  
  def country_and_regions
    brand = params[:brand].blank? ? "bss" : params[:brand]
    country_code = params[:country_code].blank? ? "us" : clean_country_code(params[:country_code])    
    regions = params[:regions].split(',').map(&:squish).map{|region| region.gsub(/[^a-zA-Z ]/, '').downcase}
    country_code_list = []
    regions.each do |region|
      country_code_list += country_codes_in_region(region) if region.present?
    end 
    
    # Make sure the country specified is first in the country_code_list
    if country_code_list.include? country_code
      country_code_list.unshift(country_code_list.delete(country_code))
    else
      country_code_list.unshift(country_code)
    end
    
    distributors_json = []
    country_code_list.each do |alpha2|
      distributors = get_distributors_json(brand, alpha2)
      distributors_json += distributors if distributors.present?
    end
    @brand = brand
    @regions = regions
    @country_code = country_code
    @distributors_json = distributors_json.uniq
    render_distributors_json
    
  end  #  country_and_regions
  
  ##### Methods #####
  
  def get_distributors_json(brand, country_code)
    distributors = DistributorInfo::Distributor.joins(:countries, :brands).where("location_info_countries.alpha2 = ? and brands.name = ?", country_code, brand).order("distributor_info_distributor_countries.position")
    
    if distributors.empty?
      distributors_json = []
    else
      distributor_tree_unfiltered_json = get_complete_distributor_tree_json(distributors)
      
      distributor_tree_locations_with_country = remove_distributor_locations_not_matching_country(distributor_tree_unfiltered_json, country_code)
      
      distributor_tree_locations_with_brand = remove_distributor_locations_not_matching_brand(distributor_tree_locations_with_country, brand)
      
      
      brand_id = Brand.find_by_name(brand).id
      country_id = LocationInfo::Country.find_by_alpha2(country_code).id
      distributor_tree_excluded_distributors_removed = remove_excluded_distributors(distributor_tree_locations_with_brand, brand_id, country_id)
      distributor_tree_excluded_locations_removed = remove_excluded_locations(distributor_tree_excluded_distributors_removed, brand_id, country_id)
      
      distributors_contacts_with_correct_data_client_json = remove_contacts_not_matching_brandsites_distributor_data_client(distributor_tree_excluded_locations_removed)
      # distributors_contacts_with_correct_data_client_json = remove_contacts_not_matching_brandsites_distributor_data_client(distributor_tree_locations_with_brand)
      
      distributors_contacts_with_correct_brand_support_json = remove_contacts_that_dont_support_brand(distributors_contacts_with_correct_data_client_json, brand)
      distributors_contacts_with_correct_country_support_json = remove_contacts_that_dont_support_country(distributors_contacts_with_correct_brand_support_json, country_code)

      # Remove distributors that have no locations, no emails, no phones, no websites. 
      # This is an edge case, where the distributor is associated with the country and brand but none of it's location are and no contact data provided.
      # Example, Harman Professional Solutions and BSS, Mexico
      distributors_json = remove_distributor_with_no_info(distributors_contacts_with_correct_country_support_json)
      
      distributors_json
    end
    
    distributors_json
  end  #  def get_distributors_json(brand, country_code)
  

  
  def country_codes_in_region(region)
    country_code_list = []
    region_country_code_list = ISO3166::Country.find_all_countries_by_region(region).collect(&:alpha2)
    sub_region_country_code_list = ISO3166::Country.find_all_countries_by_subregion(region).collect(&:alpha2)
    world_region_country_code_list = ISO3166::Country.find_all_countries_by_world_region(region).collect(&:alpha2)
    
    country_code_list = region_country_code_list.map(&:downcase) if !region_country_code_list.empty?
    country_code_list = sub_region_country_code_list.map(&:downcase) if !sub_region_country_code_list.empty?
    country_code_list = world_region_country_code_list.map(&:downcase) if !world_region_country_code_list.empty?
    
    country_code_list
  end  #  country_codes_in_region(region)
  
  private
  
  def get_complete_distributor_tree_json(distributors)
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
                          data_clients: { only: [:id, :name]},    # contact data_clients
                          supported_brands: { only: [:id, :name]}, # contact supported brands
                          supported_countries: { only: [:id, :name, :harman_name, :alpha2]} # contact supported countries
                      }  # contacts include 
                  },  # contacts
                  emails: { only: [:id, :email, :label], methods: [:email_sort_order_for_location]}, # location emails
                  phones: { only: [:id, :phone, :label], methods: [:phone_sort_order_for_location]}, # location phones
                  websites: { only: [:id, :url, :label], methods: [:website_sort_order_for_distributor]}, # location websites              
                  supported_countries: { only: [:id, :name, :harman_name, :alpha2, :world_region, :harman_world_region]},  # location supported countries
                  supported_brands: { only: [:id, :name, :url]},  # location supported brands
                  location_brand_country_exclusion_association: { only: [:location_info_location_id, :brand_id, :location_info_country_id] } # location excluded brands / countries
              } # locations include
          }, # locations 
          emails: { only: [:id, :email, :label], methods: [:email_sort_order_for_distributor]}, # distributor emails
          phones: { only: [:id, :phone, :label], methods: [:phone_sort_order_for_distributor]}, # distributor phones
          websites: { only: [:id, :url, :label], methods: [:website_sort_order_for_location]}, # distributor websites
          brands: { only: [:id, :name, :url]}, # distributor brands
          countries: { only: [:id, :name, :harman_name, :alpha2, :world_region, :harman_world_region]}, # distributor supported countries
          distributor_brand_country_exclusion_association: { only: [:distributor_info_distributor_id, :brand_id, :location_info_country_id] } # distributor excluded brands / countries
      },  #  distributors include
    )  #  distributors_json = distributors.as_json
    
    distributors_json
  end  #  get_complete_distributor_tree_json(distributors)
  
  def remove_distributor_with_no_info(distributors)
    distributors.delete_if{|distributor|
      distributor["locations"].empty? && distributor["emails"].empty? && distributor["phones"].empty? && distributor["websites"].empty?
    }  #  distributors.delete_if{|distributor|
  end  #  def remove_distributor_with_no_info(distributors)
  
  def remove_distributor_locations_not_matching_country(distributors, country_code)
    distributors_and_locations_filtered_by_country = distributors.each do |distributor|
      # removing locations that do not support country
      distributor["locations"].delete_if{|location| 
        !location["supported_countries"].select {|country| country["alpha2"].downcase == country_code }.any?
      }  #  distributor.locations.delete_if{|location|
    end  #  distributors_and_locations_filtered_by_country = distributors.each do |distributor|  
    
    distributors_and_locations_filtered_by_country
  end
  
  def remove_distributor_locations_not_matching_brand(distributors, brand)
    distributors_and_locations_filtered_by_brand = distributors.each do |distributor|
      # removing locations that do not support brand
      distributor["locations"].delete_if{|location| 
        !location["supported_brands"].select {|supported_brand| supported_brand["name"].downcase == brand }.any?
      }  #  distributor.locations.delete_if{|location|
    end  #  filter_distributor_locations_by_brand = distributors.each do |distributor|  
  
    distributors_and_locations_filtered_by_brand
  end  #  def remove_distributor_locations_not_matching_brand(distributors)
  
  def remove_contacts_not_matching_brandsites_distributor_data_client(distributors)
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
  end  #  def remove_contacts_not_matching_brandsites_distributor_data_client(distributors)

  # This situation is rare. Meaning the contact only supports some brands but not others.
  # Here we will only remove contacts that indicate that they only support certain brands and they don't match the current brand.
  def remove_contacts_that_dont_support_brand(distributors, brand)
      distributors_with_filtered_contacts = distributors.each do |distributor|
        distributor["locations"].each do |location|
          location["contacts"].delete_if {|contact|
            contact["supported_brands"].present? &&
            !contact["supported_brands"].select {|supported_brand|
              supported_brand["name"].downcase == brand
            }.any?  #  !contact["supported_brands"].select {|supported_brand|
          }  #  location["contacts"].delete_if {|contact|
        end  #  distributor["locations"].each do |location|
      end  #  distributors_with_filtered_contacts = distributors.each do |distributor|

    distributors_with_filtered_contacts
  end  #  def remove_contacts_that_dont_support_brand(distributor, brand)

  # This situation is rare. Meaning the contact only supports some countries but not others.
  # Here we will only remove contacts that indicate that they only support certain countries and they don't match the current country.
  def remove_contacts_that_dont_support_country(distributors, country_code)
      distributors_with_filtered_contacts = distributors.each do |distributor|
        distributor["locations"].each do |location|
          location["contacts"].delete_if {|contact|
            contact["supported_countries"].present? &&
            !contact["supported_countries"].select {|supported_country|
              supported_country["alpha2"].downcase == country_code
            }.any?  #  !contact["supported_countries"].select {|supported_country|
          }  #  location["contacts"].delete_if {|contact|
        end  #  distributor["locations"].each do |location|
      end  #  distributors_with_filtered_contacts = distributors.each do |distributor|

    distributors_with_filtered_contacts
  end  #  def remove_contacts_that_dont_support_brand(distributor, country)

  def remove_excluded_distributors(distributors, brand_id, country_id)
    distributors.delete_if{|distributor|
      has_exclusions = !distributor["distributor_brand_country_exclusion_association"].empty?
      if has_exclusions
         result = distributor["distributor_brand_country_exclusion_association"].select {|exclusion|
            exclusion["distributor_info_distributor_id"] == distributor["id"] && exclusion["brand_id"] == brand_id && exclusion["location_info_country_id"] == country_id
          }.any?  #  distributor["distributor_brand_country_exclusion_association"].select {|exclusion|        
      else
        false
      end
    }  #  distributors.delete_if{|distributor|
  end  #  def remove_excluded_distributors(distributors)
  
  def remove_excluded_locations(distributors, brand_id, country_id)
    distributors.each do |distributor|
      distributor["locations"].delete_if{|location|
        has_exclusions = !location["location_brand_country_exclusion_association"].empty?
        if has_exclusions
           result = location["location_brand_country_exclusion_association"].select {|exclusion|
              exclusion["location_info_location_id"] == location["id"] && exclusion["brand_id"] == brand_id && exclusion["location_info_country_id"] == country_id
            }.any?  #  location["location_brand_country_exclusion_association"].select {|exclusion|        
        else
          false
        end      
      }  #  distributor["locations"].delete_if{|location|
    end  #  distributors.each do |distributor|
  end  #  def remove_excluded_locations(distributors)

  def render_distributors_json
    respond_to do |format|
      format.html
      format.json { render json: { "distributors" => @distributors_json } }
    end
  end
end  #  class DistributorInfo::DistributorsController < ApplicationController
