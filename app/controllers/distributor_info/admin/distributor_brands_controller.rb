class DistributorInfo::Admin::DistributorBrandsController < DistributorInfo::AdminController
	before_action :initialize_distributor_brand, only: :create
	before_action :load_distributor_brand, only: [:destroy]   
	
  # GET /distributor_info/admin/distributor_brands/new
  # GET /distributor_info/admin/distributor_brands/new.xml
  def new
    respond_to do |format|
      format.html { render_template } # new.html.erb
      format.xml  { render xml: @distributor_brand }
    end
  end   
  
  # POST /distributor_info/admin/distributor_brands
  # POST /distributor_info/admin/distributor_brands.xml
  def create
    @called_from = params[:called_from] || "distributor"
    respond_to do |format|
      if @distributor_brands.present?
        begin
          @distributor_brands.each do |distributor_brand|
            begin
              distributor_brand.save!
              @distributor_brand = distributor_brand
              # website.add_log(user: current_user, action: "Associated #{distributor_brand.distributor.name} with #{distributor_brand.brand.name}")
              format.js
            rescue => e
              @error = "Error: #{e.message} : #{distributor_brand.brand.name}"
              format.js { render template: "/distributor_info/admin/distributor_brands/create_error" }
            end
          end  #  @distributor_brands.each do |distributor_brand|
          
        rescue => e
          @error = "Error: #{e.message}"
          format.js { render template: "/distributor_info/admin/distributor_brands/create_error" }
        end        
      else       
          @error = "No distributor_brands provided."
          format.html { render action: "new" }
          format.xml  { render xml: @distributor_brand.errors, status: :unprocessable_entity }
          format.js { render template: "/distributor_info/admin/distributor_brands/create_error" }
      end
    end  #  respond_to do |format|
  end  #  def create   
  
  # PUT /distributor_info/admin/distributor_brands/1
  # PUT /distributor_info/admin/distributor_brands/1.xml
  def update
    respond_to do |format|
      if @distributor_brand.update_attributes(distributor_brand_params)
        format.html { redirect_to(admin_distributor_brands_url, notice: 'distributor brand was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render action: "edit" }
        format.xml  { render xml: @distributor_brand.errors, status: :unprocessable_entity }
      end
    end
  end	   
  
  def update_order
    update_list_order(DistributorInfo::DistributorBrand, params["distributor_brand"]) # update_list_order is in application_controller
    head :ok
    # website.add_log(user: current_user, action: "Sorted distributor brands")
  end     
  
  # DELETE /distributor_info/admin/distributor_brands/1
  # DELETE /distributor_info/admin/distributor_brands/1.xml
  def destroy
    @called_from = params[:called_from] || "distributor"
    @distributor_brand.destroy
    respond_to do |format|
      format.html { redirect_to(admin_distributor_brands_url) }
      format.xml  { head :ok }
      format.js 
    end
    # website.add_log(user: current_user, action: "Removed a brand from #{@distributor_brand.distributor.name}")
  end   
  
  private

	  def initialize_distributor_brand
      if distributor_brand_params[:brand_id].is_a?(Array)
        @distributor_brands = []
        distributor_id = distributor_brand_params[:distributor_info_distributor_id]
        distributor_brand_params[:brand_id].reject(&:blank?).each do |brand|
          @distributor_brands << DistributorInfo::DistributorBrand.new({distributor_info_distributor_id: distributor_id, brand_id: brand})
        end        
      elsif distributor_brand_params[:distributor_info_distributor_id].is_a?(Array)
        @distributor_brands = []
        brand_id = distributor_brand_params[:distributor_info_brand_id]
        distributor_brand_params[:distributor_info_distributor_id].reject(&:blank?).each do |distributor|
          @distributor_brands << DistributorInfo::DistributorBrand.new({distributor_info_distributor_id: distributor, brand_id: brand_id})
        end
      end	 	    
	  end  #  def initialize_distributor_brand  
  
    def load_distributor_brand
      @distributor_brand = DistributorInfo::DistributorBrand.find(params[:id])
    end 	
	
	  def distributor_brand_params
	    params.require(:distributor_info_distributor_brand).permit!
	  end    
  
end  #  class DistributorInfo::Admin::DistributorBrandsController < DistributorInfo::AdminController
