class Cms::NewProductsController < CmsController
  before_action :set_locale_for_translator

  def index
    @new_products = NewProduct.all
    if @available_locale
      render template: 'cms/available_locales/new_products/index' and return false
    end
  end

  def show
    @new_product = NewProduct.find(params[:id])
    if @available_locale
      render template: 'cms/available_locales/new_products/edit' and return false
    end
  end

  def edit
    @new_product = NewProduct.find(params[:id])
    if @available_locale
      render template: 'cms/available_locales/new_products/edit' and return false
    end
  end

  def update
    @new_product = NewProduct.find(params[:id])
    if @new_product.update_attributes(new_product_params)
      if @available_locale
        redirect_to [:cms, @available_locale, @new_product.class], notice: 'Update successful'
      end
    else
      if @available_locale
        render template: 'cms/available_locales/new_products/edit'
      end
    end
  end

  private

  def new_product_params
    params.require(:new_product).permit(
      :name, :content, :more_info, :press_release
    )
  end
end
