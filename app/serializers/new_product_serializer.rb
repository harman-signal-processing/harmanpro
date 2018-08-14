class NewProductSerializer < ActiveModel::Serializer
  attributes :id,
    :name,
    :content,
    :brands,
    :more_info,
    :press_release,
    :month_year,
    :year,
    :image_path

  def image_path
    object.image.present? ? object.image.path(:medium) : nil
  end

  def month_year
    I18n.l(object.released_on, format: :month_year)
  end

  def year
    object.released_on.year
  end

  def brands
    object.brands.map{|b| b.name.downcase.parameterize.underscore}
  end
end
