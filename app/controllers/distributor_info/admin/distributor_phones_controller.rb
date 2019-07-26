class DistributorInfo::Admin::DistributorPhonesController < DistributorInfo::AdminController
	before_action :initialize_distributor_phone, only: :create
	before_action :load_distributor_phone, only: [:destroy]   
	
	# GET /distributor_info/admin/distributor_phones/new
  # GET /distributor_info/admin/distributor_phones/new.xml
  def new
    respond_to do |format|
      format.html { render_template } # new.html.erb
      format.xml  { render xml: @distributor_phone }
    end
  end	
  
  # POST /distributor_info/admin/distributor_phones
  # POST /distributor_info/admin/distributor_phones.xml
  def create
    @called_from = params[:called_from] || "distributor"
    respond_to do |format|
      if @distributor_phones.present?
        begin
          @distributor_phones.each do |distributor_phone|
            begin
              distributor_phone.save!
              @distributor_phone = distributor_phone
              add_log(user: current_user, action: "Associated #{distributor_phone.distributor.name} with #{distributor_phone.phone.phone}")
              format.js
            rescue => e
              @error = "Error: #{e.message} : #{distributor_phone.phone.phone}"
              format.js { render template: "/distributor_info/admin/distributor_phones/create_error" }
            end
          end  #  @distributor_phones.each do |distributor_phone|
          
        rescue => e
          @error = "Error: #{e.message}"
          format.js { render template: "/distributor_info/admin/distributor_phones/create_error" }
        end        
      else       
          @error = "Error no distributor_phones provided."
          format.html { render action: "new" }
          format.xml  { render xml: @distributor_phone.errors, status: :unprocessable_entity }
          format.js { render template: "/distributor_info/admin/distributor_phones/create_error" }
      end
    end  #  respond_to do |format|
  end  #  def create   
  
  # PUT /distributor_info/admin/distributor_phones/1
  # PUT /distributor_info/admin/distributor_phones/1.xml
  def update
    respond_to do |format|
      if @distributor_phone.update_attributes(distributor_phone_params)
        format.html { redirect_to(admin_distributor_phones_url, notice: 'distributor phone was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render action: "edit" }
        format.xml  { render xml: @distributor_phone.errors, status: :unprocessable_entity }
      end
    end
  end	  
  
  def update_order
    update_list_order(DistributorInfo::DistributorPhone, params["distributor_phone"]) # update_list_order is in application_controller
    head :ok
    add_log(user: current_user, action: "Sorted distributor phones")
  end   
  
  # DELETE /distributor_info/admin/distributor_phones/1
  # DELETE /distributor_info/admin/distributor_phones/1.xml
  def destroy
    @called_from = params[:called_from] || "distributor"
    @distributor_phone.destroy
    respond_to do |format|
      format.html { redirect_to(admin_distributor_phones_url) }
      format.xml  { head :ok }
      format.js 
    end
    add_log(user: current_user, action: "Removed #{@distributor_phone.phone.phone} from #{@distributor_phone.distributor.name}")
  end  
  
  private

	  def initialize_distributor_phone
      if distributor_phone_params[:contact_info_phone_id].is_a?(Array)
        @distributor_phones = []
        distributor_id = distributor_phone_params[:distributor_info_distributor_id]
        distributor_phone_params[:contact_info_phone_id].reject(&:blank?).each do |phone|
          @distributor_phones << DistributorInfo::DistributorPhone.new({distributor_info_distributor_id: distributor_id, contact_info_phone_id: phone})
        end        
      elsif distributor_phone_params[:distributor_info_distributor_id].is_a?(Array)
        @distributor_phones = []
        phone_id = distributor_phone_params[:contact_info_phone_id]
        distributor_phone_params[:distributor_info_distributor_id].reject(&:blank?).each do |distributor|
          @distributor_phones << DistributorInfo::DistributorPhone.new({distributor_info_distributor_id: distributor, contact_info_phone_id: phone_id})
        end
      end	 	    
	  end  #  def initialize_distributor_phone  
  
    def load_distributor_phone
      @distributor_phone = DistributorInfo::DistributorPhone.find(params[:id])
    end 	
	
	  def distributor_phone_params
	    params.require(:distributor_info_distributor_phone).permit!
	  end     
  
end  #  class DistributorInfo::Admin::DistributorPhonesController < DistributorInfo::AdminController
