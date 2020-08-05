class Cms::VerticalMarketsController < CmsController
  before_action :set_locale_for_translator

  def index
    @vertical_markets = VerticalMarket.all
    if @available_locale
      render template: 'cms/available_locales/vertical_markets/index' and return false
    end
  end

  def show
    @vertical_market = VerticalMarket.find(params[:id])
    if @available_locale
      render template: 'cms/available_locales/vertical_markets/edit' and return false
    end
  end

  def edit
    @vertical_market = VerticalMarket.find(params[:id])
    if @available_locale
      render template: 'cms/available_locales/vertical_markets/edit' and return false
    end
  end

  def update
    @vertical_market = VerticalMarket.find(params[:id])
    if @vertical_market.update(vertical_market_params)
      if @available_locale
        redirect_to [:cms, @available_locale, @vertical_market.class], notice: 'Update successful'
      end
    else
      if @available_locale
        render template: 'cms/available_locales/vertical_markets/edit'
      end
    end
  end

  private

  def vertical_market_params
    params.require(:vertical_market).permit(
      :name, :description, :headline, :lead_form_content, :extra_content
    )
  end
end
