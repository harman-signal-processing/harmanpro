class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :url,
    :tiny_photo_url,
    :small_photo_url,
    :medium_photo_url,
    :buy_now_url,
    :ecommerce_enabled

  def tiny_photo_url
    ActionController::Base.helpers.asset_path object.photo.url(:tiny)
  end

  def small_photo_url
    ActionController::Base.helpers.asset_path object.photo.url(:small)
  end

  def medium_photo_url
    ActionController::Base.helpers.asset_path object.photo.url(:medium)
  end

  # Alias of product.ecommerce_enabled? (alias without the ?)
  def ecommerce_enabled
    object.ecommerce_enabled?
  end
end
