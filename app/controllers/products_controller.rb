class ProductsController < ApplicationController
  respond_to :json

  def index
    set_brand
    @products = BrandApi.products @brand.products_api
    respond_with @products
  end

  def show
    if params[:brand_id]
      set_brand
      @product = BrandApi.product @brand.product_api(params[:id])
      respond_with @product
    else
      respond_with Product.find(params[:id])
    end
  end

  private

  def set_brand
    @brand = Brand.find(params[:brand_id])
  end

end
