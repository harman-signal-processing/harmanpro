class Cms::ProductTypesController < CmsController
  before_action :set_locale_for_translator

  def index
    @product_types = ProductType.all
    if @available_locale
      render template: 'cms/available_locales/product_types/index' and return false
    end
  end

  def show
    @product_type = ProductType.find(params[:id])
    if @available_locale
      render template: 'cms/available_locales/product_types/edit' and return false
    end
  end

  def edit
    @product_type = ProductType.find(params[:id])
    if @available_locale
      render template: 'cms/available_locales/product_types/edit' and return false
    end
  end

  def update
    @product_type = ProductType.find(params[:id])
    if @product_type.update(product_type_params)
      if @available_locale
        redirect_to [:cms, @available_locale, @product_type.class], notice: 'Update successful'
      end
    else
      if @available_locale
        render template: 'cms/available_locales/product_types/edit'
      end
    end
  end

  private

  def product_type_params
    params.require(:product_type).permit(
      :name, :description
    )
  end
end
