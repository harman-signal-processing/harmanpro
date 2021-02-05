class ContactInfo::Admin::PhonesController < ContactInfo::AdminController
  before_action :load_phone, only: [:edit, :update, :destroy]

  def index
    @phones = ContactInfo::Phone.all.order(:phone)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render xml: @phones }
      format.json  { render json: {"phones" => @phones }}
    end    
  end
  
  def new
    contact_id = params[:phone][:contact_id] unless params[:phone].nil?
    @contact = ContactInfo::Contact.find(contact_id) if contact_id.present?

    distributor_id = params[:phone][:distributor_id] unless params[:phone].nil?
    @distributor = DistributorInfo::Distributor.find(distributor_id) if distributor_id.present?
    
    location_id = params[:phone][:location_id] unless params[:phone].nil?
    @location = LocationInfo::Location.find(location_id) if location_id.present?
    
    @phone = ContactInfo::Phone.new
  end

  def edit
    @contact_phone = ContactInfo::ContactPhone.new(contact_info_phone_id: @phone.id)
    @contact_phones = ContactInfo::ContactPhone.where(contact_info_phone_id: @phone.id)
    
    @distributor_phone = DistributorInfo::DistributorPhone.new(contact_info_phone_id: @phone.id)
    @distributor_phones = DistributorInfo::DistributorPhone.where(contact_info_phone_id: @phone.id)
    
    @location_phone = LocationInfo::LocationPhone.new(contact_info_phone_id: @phone.id)
    @location_phones = LocationInfo::LocationPhone.where(contact_info_phone_id: @phone.id)
  end
  
  def update
    respond_to do |format|
      if @phone.update({phone: phone_params[:phone], label: phone_params[:label]})
        format.html { redirect_to(contact_info_admin_phones_path, notice: "Phone #{@phone.phone} was successfully updated.") }
        format.xml  { head :ok }
        add_log(user: current_user, action: "Updated phone: #{@phone.phone}")
      else
        format.html { render action: "edit" }
        format.xml  { render xml: @phone.errors, status: :unprocessable_entity }
      end
    end 
  end

  def create
    @phone = ContactInfo::Phone.new({phone: phone_params[:phone], label: phone_params[:label]})
    @contact = phone_params[:contact_id].present? ? ContactInfo::Contact.find(phone_params[:contact_id]) : nil
    @distributor = phone_params[:distributor_id].present? ? DistributorInfo::Distributor.find(phone_params[:distributor_id]) : nil
    @location = phone_params[:location_id].present? ? LocationInfo::Location.find(phone_params[:location_id]) : nil
    respond_to do |format|
      if @phone.save

        if @contact.present?
          @phone.contacts << @contact unless @contact.nil?
          add_log(user: current_user, action: "Created phone #{@phone.phone} and associated to contact #{@contact.name}")
          format.html { redirect_to(edit_contact_info_admin_contact_path(@contact), notice: "Phone #{@phone.phone} was successfully created and associated to #{@contact.name}.") }
        elsif @distributor.present?
          @phone.distributors << @distributor unless @distributor.nil?
          add_log(user: current_user, action: "Created phone #{@phone.phone} and associated to distributor #{@distributor.name}")
          format.html { redirect_to(edit_distributor_info_admin_distributor_path(@distributor), notice: "Phone #{@phone.phone} was successfully created and associated to #{@distributor.name}.") }
        elsif @location.present?
          @phone.locations << @location unless @location.nil?
          add_log(user: current_user, action: "Created phone #{@phone.phone} and associated to location #{@location.name}")
          format.html { redirect_to(edit_location_info_admin_location_path(@location), notice: "Phone #{@phone.phone} was successfully created and associated to #{@location.name}.") }                    
        else
          add_log(user: current_user, action: "Created phone #{@phone.phone}")
          format.html { redirect_to(contact_info_admin_phones_path, notice: "Phone #{@phone.phone} was successfully created.") }
        end

        format.xml  { render xml: @phone, status: :created, location: @phone }
        format.js # Not really applicable because the attachment can't be sent via AJAX
        add_log(user: current_user, action: "Created phone #{@phone.phone}")
      else
        format.html { redirect_to(contact_info_admin_phones_path, notice: "There was a problem creating the Phone #{@phone.phone}.") }
        format.xml  { render xml: @phone.errors, status: :unprocessable_entity }
        format.js { render plain: "Error" }
      end
    end      
  end

  # DELETE /contact_info/admin/phones/1
  # DELETE /contact_info/admin/phones/1.xml
  def destroy
    @phone.destroy
    respond_to do |format|
      format.html { redirect_to(contact_info_admin_phones_url) }
      format.xml  { head :ok }
    end
    add_log(user: current_user, action: "Deleted phone: #{@phone.phone}")
  end   
  
  private
  
    def load_phone
      @phone = ContactInfo::Phone.find(params[:id])
    end   
  
    def phone_params
  	  params.require(:contact_info_phone).permit(:phone, :label, :contact_id, :distributor_id, :location_id)
    end  
end  #  class ContactInfo::Admin::PhonesController < ContactInfo::AdminController
