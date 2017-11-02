class Emea::Admin::EmeaEmployeeContactsController < Emea::AdminController

  def index
    @employee_contacts = EmeaEmployeeContact.all.order("name")
    @employee_contact = EmeaEmployeeContact.new
  end

  def show
    redirect_to action: :index
  end

  def new
    @employee_contact = EmeaEmployeeContact.new
  end

  def edit
    @employee_contact = EmeaEmployeeContact.find(params[:id])
  end

  def create
    @employee_contact = EmeaEmployeeContact.new(emea_employee_contact_params)
    if @employee_contact.save
      redirect_to emea_admin_emea_employee_contacts_path, notice: "#{@employee_contact.name} created successfully."
    else
      render action: :new
    end
  end

  def update
    @employee_contact = EmeaEmployeeContact.find(params[:id])
    if @employee_contact.update_attributes(emea_employee_contact_params)
      redirect_to emea_admin_emea_employee_contacts_path, notice: "#{@employee_contact.name} updated successfully."
    else
      render action: :edit
    end
  end

  def destroy
    @employee_contact = EmeaEmployeeContact.find(params[:id])
    if @employee_contact.destroy
      redirect_to emea_admin_emea_employee_contacts_path
    end
  end

  private

  def emea_employee_contact_params
    params.require(:emea_employee_contact).permit(:name, :email, :telephone, :mobile, :department, :job_function, :position, :brands, :country)
  end
end
