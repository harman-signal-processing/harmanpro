class ServiceCentersController < ApplicationController
  respond_to :json

  # GET /service_centers
  # GET /service_centers.json
  # This is the service center search page
  def index
    @search = ServiceCenter.active.ransack(params[:q])
    @selected = nil
    @selected_group = nil
    if params[:q]
      @selected = params[:q][:state_eq]
      @selected_group = params[:q][:service_groups_name_eq]
      @service_centers = @search.result
    end
  end

  # GET /service_centers/login
  # (Not really a login page, but links to brands' tech login pages.)
  def login
    @brands = Brand.for_service_site
  end

  # GET /service_centers/new
  def new
    @service_center = ServiceCenter.new
  end

  # POST /service_centers
  # POST /service_centers.json
  def create
    @service_center = ServiceCenter.new(service_center_params)
    @service_center.active = false

    respond_to do |format|
      if @service_center.save
        ServiceCenterMailer.registration(@service_center).deliver_later
        format.html { redirect_to service_center_login_path, notice: 'Thank you for your interest in becoming a HARMAN authorized service center. We will get back with you shortly.' }
      else
        format.html { render :new }
      end
    end
  end

  def service_centers_for_brand
    brand = params[:brand].nil? ? "bss" : params[:brand]
    brand_id = Brand.find_by_name(brand).id
    state = params[:state].nil? ? "any" : params[:state]
    service_groups = ServiceGroup.where("brand_id = ?", brand_id).uniq
    if state == "any"
      service_centers = ServiceCenter.joins(:service_groups).where("service_group_id in (?) and active = true",service_groups.pluck(:id))
    else
      service_centers = ServiceCenter.joins(:service_groups).where("service_group_id in (?) and state = ? and active = true",service_groups.pluck(:id), state)
    end
    
    result = service_centers.as_json(
       except: [:created_at, :updated_at],  # exclude these service center attributes
       include: { 
         service_groups: { 
           only:[:id, :name, ],
           include: { 
             brand: {
               only:[:id, :name]
             }  #  brand
           }  #  service groups include
         }  # service groups
       },  # service centers include
      )  #  result = service_groups.as_json(
      
    # Will need to filter out service groups that don't match brand
    filtered_result = remove_service_groups_not_matching_brand(result, brand_id)
      
    respond_with filtered_result
    
  end  #  def service_centers_for_brand    

  private

  def remove_service_groups_not_matching_brand(service_centers, brand_id)
    service_centers_and_service_groups_filtered_by_brand = service_centers.each do |service_center|
      # removing service groups not associated to brand
      service_center["service_groups"].delete_if{|service_group|
        service_group["brand"]["id"] != brand_id
      }  #  service_center["service_groups"].delete_if{|service_group|
    end  #  service_centers_and_service_groups_filtered_by_brand = service_centers.each do |sc|
    service_centers_and_service_groups_filtered_by_brand
  end  #  def remove_service_groups_not_matching_brand(service_centers, brand_id)

    # Never trust parameters from the scary internet, only allow the white list through.
    def service_center_params
      params.require(:service_center).permit(:name, :contact_name, :address, :city, :state, :zip, :phone, :fax, :email, :website, :account_number, :willingness)
    end
end
