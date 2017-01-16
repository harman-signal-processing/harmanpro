require 'rails_helper'

RSpec.describe Cms::VerticalMarketsController, type: :controller do
  before :all do
    @available_locale = FactoryGirl.create(:available_locale, key: 'es')
    @admin_user = FactoryGirl.create(:admin_user, translator: true)
    @vertical_market = FactoryGirl.create(:vertical_market)
  end

  after :all do
    DatabaseCleaner.clean_with :truncation
  end

  before :each do
    sign_in(@admin_user, scope: :admin_user)
  end

  describe "sub-folder of available_locale" do
    describe "GET :index" do
      it "assigns locale and loads vertical_markets" do
        get :index, params: { available_locale_id: @available_locale.to_param }

        expect(assigns(:available_locale)).to eq(@available_locale)
        expect(assigns(:vertical_markets)).to include(@vertical_market)
        expect(response).to render_template('cms/available_locales/vertical_markets/index')
      end
    end

    describe "GET :show" do
      it "shows the vertical_market" do
        get :show, params: { available_locale_id: @available_locale.to_param, id: @vertical_market.to_param }

        expect(I18n.locale).to eq(@available_locale.key.to_sym)
        expect(assigns(:available_locale)).to eq(@available_locale)
        expect(assigns(:vertical_market)).to eq(@vertical_market)
        expect(response).to render_template('cms/available_locales/vertical_markets/edit')
      end
    end

    describe "GET :edit" do
      it "assigns locale and vertical_market and renders form" do
        get :edit, params: { available_locale_id: @available_locale.to_param, id: @vertical_market.to_param }

        expect(I18n.locale).to eq(@available_locale.key.to_sym)
        expect(assigns(:available_locale)).to eq(@available_locale)
        expect(assigns(:vertical_market)).to eq(@vertical_market)
        expect(response).to render_template('cms/available_locales/vertical_markets/edit')
      end
    end

    describe "PUT :update" do
      it "updates the vertical_market" do
        put :update, params: {
          available_locale_id: @available_locale.to_param, id: @vertical_market.to_param,
          vertical_market: { description: 'New description' }
        }

        @vertical_market.reload
        expect(@vertical_market.description).to eq('New description')
        expect(response).to redirect_to cms_available_locale_vertical_markets_path(@available_locale)
      end
    end
  end

end
