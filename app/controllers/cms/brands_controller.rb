class Cms::BrandsController < CmsController
  before_action :set_locale_for_translator

  def index
    @brands = Brand.all
    if @available_locale
      render template: 'cms/available_locales/brands/index' and return false
    end
  end

  def show
    @brand = Brand.find(params[:id])
    if @available_locale
      render template: 'cms/available_locales/brands/edit' and return false
    end
  end

  def edit
    @brand = Brand.find(params[:id])
    if @available_locale
      render template: 'cms/available_locales/brands/edit' and return false
    end
  end

  def update
    @brand = Brand.find(params[:id])
    if @brand.update(brand_params)
      if @available_locale
        redirect_to [:cms, @available_locale, @brand.class], notice: 'Update successful'
      end
    else
      if @available_locale
        render template: 'cms/available_locales/brands/edit'
      end
    end
  end

  private

  def brand_params
    params.require(:brand).permit(
      :name,
      :description,
      :logo,
      :white_logo,
      :by_harman_logo,
      :logo_collection,
      :url,
      :downloads_page_url,
      :support_url,
      :training_url,
      :tech_url,
      :api_url,
      :marketing_url,
      :show_on_main_site,
      :show_on_service_site,
      :show_on_consultants_page,
      :show_on_training_page,
      :contact_info_for_consultants
    )
  end
end
