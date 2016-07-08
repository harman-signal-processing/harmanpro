require 'rails_helper'

RSpec.describe Cms::SiteSettingsController, type: :controller do
  before :all do
    @available_locale = FactoryGirl.create(:available_locale, key: 'es')
    @admin_user = FactoryGirl.create(:admin_user, translator: true)
    @site_setting = FactoryGirl.create(:site_setting)
  end

  after :all do
    DatabaseCleaner.clean_with :truncation
  end

  before :each do
    sign_in(@admin_user, scope: :admin_user)
  end

  describe "sub-folder of available_locale" do
    describe "GET :index" do
      it "assigns locale and loads site_settings" do
        get :index, available_locale_id: @available_locale.to_param

        expect(assigns(:available_locale)).to eq(@available_locale)
        expect(assigns(:site_settings)).to include(@site_setting)
        expect(response).to render_template('cms/available_locales/site_settings/index')
      end
    end

    describe "GET :show" do
      it "shows the site_setting" do
        get :show, available_locale_id: @available_locale.to_param, id: @site_setting.to_param

        expect(I18n.locale).to eq(@available_locale.key.to_sym)
        expect(assigns(:available_locale)).to eq(@available_locale)
        expect(assigns(:site_setting)).to eq(@site_setting)
        expect(response).to render_template('cms/available_locales/site_settings/edit')
      end
    end

    describe "GET :edit" do
      it "assigns locale and site_setting and renders form" do
        get :edit, available_locale_id: @available_locale.to_param, id: @site_setting.to_param

        expect(I18n.locale).to eq(@available_locale.key.to_sym)
        expect(assigns(:available_locale)).to eq(@available_locale)
        expect(assigns(:site_setting)).to eq(@site_setting)
        expect(response).to render_template('cms/available_locales/site_settings/edit')
      end
    end

    describe "PUT :update" do
      it "updates the site_setting" do
        put :update, available_locale_id: @available_locale.to_param, id: @site_setting.to_param,
          site_setting: { content: 'New description' }

        @site_setting.reload
        expect(@site_setting.content).to eq('New description')
        expect(response).to redirect_to cms_available_locale_site_settings_path(@available_locale)
      end
    end
  end

end
