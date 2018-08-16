class NewProductSerializer < ActiveModel::Serializer
  attributes :id,
    :name,
    :content,
    :brands,
    :product_types,
    :more_info,
    :press_release,
    :month_year,
    :year,
    :image_url

  def image_url
    object.image.present? ? expanded_image_url : nil
  end

  def month_year
    I18n.l(object.released_on, format: :month_year)
  end

  def year
    object.released_on.year
  end

  def brands
    object.brands.map{|b| b.friendly_id.underscore}
  end

  def product_types
    object.product_types.map{|pt| pt.friendly_id.underscore}
  end

  private

  def expanded_image_url
    ActionController::Base.helpers.asset_path object.image.url(:medium)
  end
end
