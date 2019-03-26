class ContactInfo::Admin::TeamGroupsController < ContactInfo::AdminController
  before_action :load_team_group, only: [:edit, :update, :destroy]
  
  def index
    @team_groups = ContactInfo::TeamGroup.all.order(:name)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render xml: @team_groups }
      format.json  { render json: @team_groups }
    end    
  end
  
  def new
    contact_id = params[:team_group][:contact_id] unless params[:team_group].nil?
    @contact = ContactInfo::Contact.find(contact_id) if contact_id.present?
    @team_group = ContactInfo::TeamGroup.new
  end
  
  def edit
    @contact_team_group = ContactInfo::ContactTeamGroup.new(contact_info_team_group_id: @team_group.id)
    @contact_team_groups = ContactInfo::ContactTeamGroup.where(contact_info_team_group_id: @team_group.id)
  end
  
  def update
    respond_to do |format|
      if @team_group.update_attributes({team_group: team_group_params[:name]})
        format.html { redirect_to(contact_info_admin_team_groups_path, notice: "TeamGroup #{@team_group.team_group} was successfully updated.") }
        format.xml  { head :ok }
        # website.add_log(user: current_user, action: "Updated team_group: #{@team_group.name}")
      else
        format.html { render action: "edit" }
        format.xml  { render xml: @team_group.errors, status: :unprocessable_entity }
      end
    end 
  end
  
  def create
    @team_group = ContactInfo::TeamGroup.new({team_group: team_group_params[:name]})
    @contact = team_group_params[:contact_id].present? ? ContactInfo::Contact.find(team_group_params[:contact_id]) : nil
    respond_to do |format|
      if @team_group.save

        @team_group.contacts << @contact unless @contact.nil?

        format.html { redirect_to(contact_info_admin_team_groups_path, notice: "TeamGroup #{@team_group.name} was successfully created.") }
        format.xml  { render xml: @team_group, status: :created, location: @team_group }
        format.js # Not really applicable because the attachment can't be sent via AJAX
        # website.add_log(user: current_user, action: "Created team_group #{@team_group.name}")
      else
        format.html { redirect_to(contact_info_admin_team_groups_path, notice: "There was a problem creating the TeamGroup #{@team_group.name}.") }
        format.xml  { render xml: @team_group.errors, status: :unprocessable_entity }
        format.js { render plain: "Error" }
      end
    end      
  end
  
  # DELETE /contact_info/admin/team_groups/1
  # DELETE /contact_info/admin/team_groups/1.xml
  def destroy
    @team_group.destroy
    respond_to do |format|
      format.html { redirect_to(contact_info_admin_team_groups_url) }
      format.xml  { head :ok }
    end
    # website.add_log(user: current_user, action: "Deleted team_group: #{@team_group.name}")
  end  
  
  private
  
    def load_team_group
      @team_group = ContactInfo::TeamGroup.find(params[:id])
    end   
  
    def team_group_params
  	  params.require(:contact_info_team_group).permit(:name, :contact_id)
    end  
    
end  #  class ContactInfo::Admin::TeamGroupsController < ContactInfo::AdminController
