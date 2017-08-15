class Emea::Admin::EmeaPagesController < Emea::AdminController

  def index
    @emea_pages = EmeaPage.all.order("title")
  end

  def new
    @emea_page = EmeaPage.new
  end

  def edit
    @emea_page = EmeaPage.find(params[:id])
  end

  def create
    @emea_page = EmeaPage.new(emea_page_params)
    if @emea_page.save
      if params[:next_step] == "edit"
        redirect_to edit_emea_admin_emea_page_path(@emea_page) and return false
      else
        redirect_to emea_admin_emea_pages_path, notice: "Page created successfully." and return false
      end
    else
      render action: :new
    end
  end

  def update
    @emea_page = EmeaPage.find(params[:id])
    if @emea_page.update_attributes(emea_page_params)
      redirect_to emea_admin_emea_pages_path, notice: "Page updated successfully." and return false
    else
      render action: :edit
    end
  end

  def destroy
    @emea_page = EmeaPage.find(params[:id])
    @emea_page.destroy
    redirect_to emea_admin_emea_pages_path, notice: "Page \'#{@emea_page.title}\' was deleted successfully."
  end

  private

  def emea_page_params
    params.require(:emea_page).permit(:title, :position, :publish_on, :highlight_color, :content, :pinch_content, :custom_header_code)
  end

end
