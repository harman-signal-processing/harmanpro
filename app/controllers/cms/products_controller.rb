class Cms::ProductsController < CmsController
  before_action :set_locale_for_translator

  def index
    @products = Product.all
    if @available_locale
      render template: 'cms/available_locales/products/index' and return false
    end
  end

  def show
    @product = Product.find(params[:id])
    if @available_locale
      render template: 'cms/available_locales/products/edit' and return false
    end
  end

  def edit
    @product = Product.find(params[:id])
    if @available_locale
      render template: 'cms/available_locales/products/edit' and return false
    end
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      if @available_locale
        redirect_to [:cms, @available_locale, @product.class], notice: 'Update successful'
      end
    else
      if @available_locale
        render template: 'cms/available_locales/products/edit'
      end
    end
  end

  private

  def product_params
    params.require(:product).permit(
      :name, :description
    )
  end
end
