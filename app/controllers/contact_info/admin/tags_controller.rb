class ContactInfo::Admin::TagsController < ContactInfo::AdminController
  before_action :load_tag, only: [:edit, :update, :destroy]
  
  def index
    @tags = ContactInfo::Tag.all.order(:name)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render xml: @tags }
      format.json  { render json: @tags }
    end    
  end
  
  def new
    contact_id = params[:tag][:contact_id] unless params[:tag].nil?
    @contact = ContactInfo::Contact.find(contact_id) if contact_id.present?
    @tag = ContactInfo::Tag.new
  end
  
  def edit
    @contact_tag = ContactInfo::ContactTag.new(contact_info_tag_id: @tag.id)
    @contact_tags = ContactInfo::ContactTag.where(contact_info_tag_id: @tag.id)
  end
  
  def update
    respond_to do |format|
      if @tag.update({tag: tag_params[:tag]})
        format.html { redirect_to(contact_info_admin_tags_path, notice: "Tag #{@tag.name} was successfully updated.") }
        format.xml  { head :ok }
        add_log(user: current_user, action: "Updated tag: #{@tag.name}")
      else
        format.html { render action: "edit" }
        format.xml  { render xml: @tag.errors, status: :unprocessable_entity }
      end
    end 
  end
  
  def create
    @tag = ContactInfo::Tag.new({name: tag_params[:name]})
    @contact = tag_params[:contact_id].present? ? ContactInfo::Contact.find(tag_params[:contact_id]) : nil
    respond_to do |format|
      if @tag.save

        @tag.contacts << @contact unless @contact.nil?

        format.html { redirect_to(contact_info_admin_tags_path, notice: "Tag #{@tag.name} was successfully created.") }
        format.xml  { render xml: @tag, status: :created, location: @tag }
        format.js # Not really applicable because the attachment can't be sent via AJAX
        add_log(user: current_user, action: "Created tag #{@tag.name}")
      else
        format.html { redirect_to(contact_info_admin_tags_path, notice: "There was a problem creating the Tag #{@tag.name}.") }
        format.xml  { render xml: @tag.errors, status: :unprocessable_entity }
        format.js { render plain: "Error" }
      end
    end      
  end
  
  # DELETE /contact_info/admin/tags/1
  # DELETE /contact_info/admin/tags/1.xml
  def destroy
    @tag.destroy
    respond_to do |format|
      format.html { redirect_to(contact_info_admin_tags_url) }
      format.xml  { head :ok }
    end
    add_log(user: current_user, action: "Deleted tag: #{@tag.name}")
  end

  private
  
    def load_tag
      @tag = ContactInfo::Tag.find(params[:id])
    end   
  
    def tag_params
  	  params.require(:contact_info_tag).permit(:name, :contact_id)
    end   
end  #  class ContactInfo::Admin::TagsController < ContactInfo::AdminController
