class Cms::ArtistsController < CmsController
  before_action :set_locale_for_translator

  def index
    if @available_locale
      @artists = @available_locale.artists
      render template: 'cms/available_locales/artists/index' and return false
    end
  end

  def new
    @artist = Artist.new
    render template: 'cms/available_locales/artists/new' and return false
  end

  def create
    @artist = Artist.new(artist_params)
    @artist.locale = @available_locale

    if @artist.save
      redirect_to [:cms, @available_locale, @artist.class], notice: "Artist was created"
    else
      render template: 'cms/available_locales/artists/new'
    end
  end

  def show
    @artist = Artist.find(params[:id])
    render template: 'cms/available_locales/artists/edit' and return false
  end

  def edit
    @artist = Artist.find(params[:id])
    render template: 'cms/available_locales/artists/edit' and return false
  end

  def update
    @artist = Artist.find(params[:id])
    if @artist.update(artist_params)
      redirect_to [:cms, @available_locale, @artist.class], notice: 'Update successful'
    else
      render template: 'cms/available_locales/artists/edit'
    end
  end

  def destroy
    @artist = Artist.find(params[:id])
    @artist.destroy
    redirect_to [:cms, @available_locale, @artist.class], notice: "Artist was deleted."
  end

  private

  def artist_params
    params.require(:artist).permit(
      :name,
      :description,
      :overview,
      :photo,
      :delete_photo
    )
  end

end
