class Tse::TseContactsController < TseController
  respond_to :json

  def index
    @contacts = TseContact.all
    if params[:category_id]
      @contacts = TseCategory.find(params[:category_id]).tse_contacts
    end
    respond_with @contacts
  end

  def show
    respond_with TseContact.find(params[:id])
  end

end


