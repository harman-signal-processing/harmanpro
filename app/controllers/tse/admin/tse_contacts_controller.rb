class Tse::Admin::TseContactsController < Tse::AdminController
  before_action :load_contact, except: [:index, :new, :create]

  def index
    @tse_contacts = TseContact.all
  end

  def show
  end

  def new
    @tse_contact = TseContact.new
  end

  def edit
  end

  def create
    @tse_contact = TseContact.new(tse_contact_params)
    if @tse_contact.save
      redirect_to tse_admin_tse_contacts_path, notice: "The contact was created successfully."
    else
      render action: :new
    end
  end

  def update
    if @tse_contact.update_attributes(tse_contact_params)
      redirect_to tse_admin_tse_contacts_path
    else
      render action: :edit
    end
  end

  def destroy
    if @tse_contact.destroy
      redirect_to tse_admin_tse_contacts_path
    end
  end

  private

  def load_contact
    @tse_contact = TseContact.find(params[:id])
    #authorize @tse_contact
  end

  def tse_contact_params
    params.require(:tse_contact).permit(:name,
                                       :job_title,
                                       :phone,
                                       :email,
                                       :address,
                                       :manager,
                                       :company,
                                       tse_category_ids: [],
                                       tse_technology_ids: [],
                                       tse_region_ids: [],
                                       tse_domain_ids: []
                                       )
  end
end

