class Emea::Admin::EmeaPageResourcesController < Emea::AdminController
  before_action :load_emea_page

  def index
    @emea_page_resources = @emea_page.resources
  end

  def new
    @emea_page_resource = EmeaPageResource.new(emea_page: @emea_page)
    if params[:featured]
      @emea_page_resource.featured = true
    end
  end

  def edit
    @emea_page_resource = @emea_page.resources.find(params[:id])
  end

  def create
    @emea_page_resource = EmeaPageResource.new(emea_page_resource_params)
    @emea_page_resource.emea_page = @emea_page
    if @emea_page_resource.save
      redirect_to edit_emea_admin_emea_page_path(@emea_page), notice: "Resource was uploaded successfully."
    else
      render action: :edit
    end
  end

  def update
    @emea_page_resource = @emea_page.resources.find(params[:id])
    if @emea_page_resource.update_attributes(emea_page_resource_params)
      redirect_to edit_emea_admin_emea_page_path(@emea_page), notice: "Resource was updated successfully."
    else
      render action: :edit
    end
  end

  def destroy
    @emea_page_resource = @emea_page.resources.find(params[:id])
    @emea_page_resource.destroy
    redirect_to edit_emea_admin_emea_page_path(@emea_page), notice: "Resource was deleted successfully."
  end

  private

  def load_emea_page
    @emea_page = EmeaPage.find(params[:emea_page_id])
  end

  def emea_page_resource_params
    params.require(:emea_page_resource).permit(:name, :attachment, :featured, :position, :link, :new_window)
  end
end
