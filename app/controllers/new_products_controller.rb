class NewProductsController < ApplicationController
  respond_to :html, :json

  def index
    if params[:show_future].present? && admin_logged_in?
      @new_products = NewProduct.order(Arel.sql("released_on DESC"))
    else
      @new_products = NewProduct.where("released_on <= ?", Date.today).order(Arel.sql("released_on DESC"))
    end
    respond_with @new_products
  end

end
