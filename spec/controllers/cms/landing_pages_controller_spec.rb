require 'rails_helper'

RSpec.describe Cms::LandingPagesController, type: :controller do
  before :all do
    FactoryGirl.create(:available_locale, key: I18n.default_locale.to_s)
    @available_locale = FactoryGirl.create(:available_locale, key: 'es')
    @admin_user = FactoryGirl.create(:user, translator: true)
    @landing_page = FactoryGirl.create(:landing_page)
  end

  after :all do
    DatabaseCleaner.clean_with :truncation
  end

  before :each do
    sign_in(@admin_user, scope: :user)
  end

  describe "sub-folder of available_locale" do
    describe "GET :index" do
      it "assigns locale and loads landing pages" do
        get :index, params: { available_locale_id: @available_locale.to_param }

        expect(assigns(:available_locale)).to eq(@available_locale)
        expect(assigns(:landing_pages)).to include(@landing_page)
        expect(response).to render_template('cms/available_locales/landing_pages/index')
      end
    end

    describe "GET :show" do
      it "shows the landing page" do
        get :show, params: { available_locale_id: @available_locale.to_param, id: @landing_page.to_param }

        expect(I18n.locale).to eq(@available_locale.key.to_sym)
        expect(assigns(:available_locale)).to eq(@available_locale)
        expect(assigns(:landing_page)).to eq(@landing_page)
        expect(response).to render_template('cms/available_locales/landing_pages/edit')
      end
    end

    describe "GET :edit" do
      it "assigns locale and landing_page and renders form" do
        get :edit, params: { available_locale_id: @available_locale.to_param, id: @landing_page.to_param }

        expect(I18n.locale).to eq(@available_locale.key.to_sym)
        expect(assigns(:available_locale)).to eq(@available_locale)
        expect(assigns(:landing_page)).to eq(@landing_page)
        expect(response).to render_template('cms/available_locales/landing_pages/edit')
      end
    end

    describe "PUT :update" do
      it "updates the landing_page" do
        put :update, params: {
          available_locale_id: @available_locale.to_param, id: @landing_page.to_param,
          landing_page: { description: 'New description' }
        }

        @landing_page.reload
        expect(@landing_page.description).to eq('New description')
        expect(response).to redirect_to cms_available_locale_landing_pages_path(@available_locale)
      end
    end
  end

end
