require 'rails_helper'

RSpec.describe Cms::VenuesController, type: :controller do
  before :all do
    @available_locale = FactoryBot.create(:available_locale, key: 'es')
    @admin_user = FactoryBot.create(:user, translator: true)
    @venue = FactoryBot.create(:venue)
  end

  after :all do
    DatabaseCleaner.clean_with :truncation
  end

  before :each do
    sign_in(@admin_user, scope: :user)
  end

  describe "sub-folder of available_locale" do
    describe "GET :index" do
      it "assigns locale and loads venues" do
        get :index, params: { available_locale_id: @available_locale.to_param }

        expect(assigns(:available_locale)).to eq(@available_locale)
        expect(assigns(:venues)).to include(@venue)
        expect(response).to render_template('cms/available_locales/venues/index')
      end
    end

    describe "GET :show" do
      it "shows the venue" do
        get :show, params: { available_locale_id: @available_locale.to_param, id: @venue.to_param }

        expect(I18n.locale).to eq(@available_locale.key.to_sym)
        expect(assigns(:available_locale)).to eq(@available_locale)
        expect(assigns(:venue)).to eq(@venue)
        expect(response).to render_template('cms/available_locales/venues/edit')
      end
    end

    describe "GET :edit" do
      it "assigns locale and venue and renders form" do
        get :edit, params: { available_locale_id: @available_locale.to_param, id: @venue.to_param }

        expect(I18n.locale).to eq(@available_locale.key.to_sym)
        expect(assigns(:available_locale)).to eq(@available_locale)
        expect(assigns(:venue)).to eq(@venue)
        expect(response).to render_template('cms/available_locales/venues/edit')
      end
    end

    describe "PUT :update" do
      it "updates the venue" do
        put :update, params: {
          available_locale_id: @available_locale.to_param, id: @venue.to_param,
          venue: { description: 'New description' }
        }

        @venue.reload
        expect(@venue.description).to eq('New description')
        expect(response).to redirect_to cms_available_locale_venues_path(@available_locale)
      end
    end
  end

end
