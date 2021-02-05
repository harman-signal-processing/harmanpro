class VerticalMarketShortSerializer < ActiveModel::Serializer
  attributes :id, :name, :slug, :live, :translations

  def translations
    object.translations.select(:vertical_market_id, :locale, :name, :slug)
  end
end
