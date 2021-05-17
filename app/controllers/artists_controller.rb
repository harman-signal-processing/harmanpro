class ArtistsController < ApplicationController
  respond_to :html, :json

  def index
    @artists = filter_by_locale(Artist.all).limit(999).order(Arel.sql("name DESC"))
  end

  def show
    @artist = Artist.find(params[:id])
  end

  private

  # Removes artists which don't belong to the current locale.
  # We fall back to artists with no locale, or default locale.
  #
  def filter_by_locale(artists)
    included_locales = []
    if AvailableLocale.exists?(key: I18n.locale)
      included_locales << AvailableLocale.find_by(key: I18n.locale).id
    end
    if included_locales.size == 0
      included_locales = [nil, '', AvailableLocale.default_id]
    end
    artists.where(locale_id: included_locales)
  end
end
