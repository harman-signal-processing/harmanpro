class DistributorInfo::Admin::DistributorWebsitesController < DistributorInfo::AdminController
	before_action :initialize_distributor_website, only: :create
	before_action :load_distributor_website, only: [:destroy] 
	
	# GET /distributor_info/admin/distributor_websites/new
  # GET /distributor_info/admin/distributor_websites/new.xml
  def new
    respond_to do |format|
      format.html { render_template } # new.html.erb
      format.xml  { render xml: @distributor_website }
    end
  end	
	
  # POST /distributor_info/admin/distributor_websites
  # POST /distributor_info/admin/distributor_websites.xml
  def create
    @called_from = params[:called_from] || "distributor"
    respond_to do |format|
      if @distributor_websites.present?
        begin
          @distributor_websites.each do |distributor_website|
            begin
              distributor_website.save!
              @distributor_website = distributor_website
              add_log(user: current_user, action: "Associated #{distributor_website.distributor.name} with #{distributor_website.website.url}")
              format.js
            rescue => e
              @error = "Error: #{e.message} : #{distributor_website.website.url}"
              format.js { render template: "/distributor_info/admin/distributor_websites/create_error" }
            end
          end  #  @distributor_websites.each do |distributor_website|
          
        rescue => e
          @error = "Error: #{e.message}"
          format.js { render template: "/distributor_info/admin/distributor_websites/create_error" }
        end        
      else       
          @error = "Error no distributor_websites provided."
          format.html { render action: "new" }
          format.xml  { render xml: @distributor_website.errors, status: :unprocessable_entity }
          format.js { render template: "/distributor_info/admin/distributor_websites/create_error" }
      end
    end  #  respond_to do |format|
  end  #  def create	
	
  # PUT /distributor_info/admin/distributor_websites/1
  # PUT /distributor_info/admin/distributor_websites/1.xml
  def update
    respond_to do |format|
      if @distributor_website.update_attributes(distributor_website_params)
        format.html { redirect_to(admin_distributor_websites_url, notice: 'distributor website was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render action: "edit" }
        format.xml  { render xml: @distributor_website.errors, status: :unprocessable_entity }
      end
    end
  end	
	
  def update_order
    update_list_order(DistributorInfo::DistributorWebsite, params["distributor_website"]) # update_list_order is in application_controller
    head :ok
    add_log(user: current_user, action: "Sorted distributor websites")
  end  	
	
  # DELETE /distributor_info/admin/distributor_websites/1
  # DELETE /distributor_info/admin/distributor_websites/1.xml
  def destroy
    @called_from = params[:called_from] || "distributor"
    @distributor_website.destroy
    respond_to do |format|
      format.html { redirect_to(admin_distributor_websites_url) }
      format.xml  { head :ok }
      format.js 
    end
    add_log(user: current_user, action: "Removed #{@distributor_website.website.url} from #{@distributor_website.distributor.name}")
  end 
  
  private

	  def initialize_distributor_website
      if distributor_website_params[:contact_info_website_id].is_a?(Array)
        @distributor_websites = []
        distributor_id = distributor_website_params[:distributor_info_distributor_id]
        distributor_website_params[:contact_info_website_id].reject(&:blank?).each do |website|
          @distributor_websites << DistributorInfo::DistributorWebsite.new({distributor_info_distributor_id: distributor_id, contact_info_website_id: website})
        end        
      elsif distributor_website_params[:distributor_info_distributor_id].is_a?(Array)
        @distributor_websites = []
        website_id = distributor_website_params[:contact_info_website_id]
        distributor_website_params[:distributor_info_distributor_id].reject(&:blank?).each do |distributor|
          @distributor_websites << DistributorInfo::DistributorWebsite.new({distributor_info_distributor_id: distributor, contact_info_website_id: website_id})
        end
      end	 	    
	  end  #  def initialize_distributor_website  
  
    def load_distributor_website
      @distributor_website = DistributorInfo::DistributorWebsite.find(params[:id])
    end 	
	
	  def distributor_website_params
	    params.require(:distributor_info_distributor_website).permit!
	  end   
  
end  #  class DistributorInfo::Admin::DistributorWebsitesController < DistributorInfo::AdminController
