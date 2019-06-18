class ContactInfo::Admin::ContactTeamGroupsController < ContactInfo::AdminController
  before_action :initialize_contact_team_group, only: :create
	before_action :load_contact_team_group, only: [:destroy]
	
  # GET /contact_info/admin/contact_team_groups/new
  # GET /contact_info/admin/contact_team_groups/new.xml
  def new
    respond_to do |format|
      format.html { render_template } # new.html.erb
      format.xml  { render xml: @contact_team_group }
    end
  end
  
  # POST /contact_info/admin/contact_team_groups
  # POST /contact_info/admin/contact_team_groups.xml
  def create
    @called_from = params[:called_from] || "contact"
    respond_to do |format|
      if @contact_team_groups.present?
        begin
          @contact_team_groups.each do |contact_team_group|
            begin
              contact_team_group.save!
              @contact_team_group = contact_team_group
              # website.add_log(user: current_user, action: "Associated #{contact_team_group.contact.name} with #{contact_team_group.team_group.name}")
              format.js
            rescue => e
              @error = "Error: #{e.message} : #{contact_team_group.team_group.name}"
              format.js { render template: "/contact_info/admin/contact_team_groups/create_error" }
            end
          end  #  @contact_team_groups.each do |contact_team_group|
          
        rescue => e
          @error = "Error: #{e.message}"
          format.js { render template: "/contact_info/admin/contact_team_groups/create_error" }
        end        
      else       
          @error = "No team_groups provided."
          format.html { render action: "new" }
          format.xml  { render xml: @contact_team_group.errors, status: :unprocessable_entity }
          format.js { render template: "/contact_info/admin/contact_team_groups/create_error" }
      end
    end  #  respond_to do |format|
  end  #  def create
  
  # PUT /contact_info/admin/contact_team_groups/1
  # PUT /contact_info/admin/contact_team_groups/1.xml
  def update
    respond_to do |format|
      if @contact_team_group.update_attributes(contact_team_group_params)
        format.html { redirect_to(admin_contact_team_groups_url, notice: 'Contact team_group was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render action: "edit" }
        format.xml  { render xml: @contact_team_group.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def update_order
    update_list_order(ContactInfo::ContactTeamGroup, params["contact_team_group"]) # update_list_order is in application_controller
    head :ok
    # website.add_log(user: current_user, action: "Sorted contact team_groups")
  end 

  # DELETE /contact_info/admin/contact_team_groups/1
  # DELETE /contact_info/admin/contact_team_groups/1.xml
  def destroy
    @called_from = params[:called_from] || "contact"
    @contact_team_group.destroy
    respond_to do |format|
      format.html { redirect_to(admin_contact_team_groups_url) }
      format.xml  { head :ok }
      format.js 
    end
    # website.add_log(user: current_user, action: "Removed a team_group from #{@contact_team_group.contact.name}")
  end 
  
  private

	  def initialize_contact_team_group
      if contact_team_group_params[:contact_info_team_group_id].is_a?(Array)
        @contact_team_groups = []
        contact_id = contact_team_group_params[:contact_info_contact_id]
        contact_team_group_params[:contact_info_team_group_id].reject(&:blank?).each do |team_group|
          @contact_team_groups << ContactInfo::ContactTeamGroup.new({contact_info_contact_id: contact_id, contact_info_team_group_id: team_group})
        end        
      elsif contact_team_group_params[:contact_info_contact_id].is_a?(Array)
        @contact_team_groups = []
        team_group_id = contact_team_group_params[:contact_info_team_group_id]
        contact_team_group_params[:contact_info_contact_id].reject(&:blank?).each do |contact|
          @contact_team_groups << ContactInfo::ContactTeamGroup.new({contact_info_contact_id: contact, contact_info_team_group_id: team_group_id})
        end
      end	 	    
	  end  #  def initialize_contact_team_group
	
    def load_contact_team_group
      @contact_team_group = ContactInfo::ContactTeamGroup.find(params[:id])
    end 	
	
	  def contact_team_group_params
	    params.require(:contact_info_contact_team_group).permit!
	  end
	  
end  #  class ContactInfo::Admin::ContactTeamGroupsController < ContactInfo::AdminController
