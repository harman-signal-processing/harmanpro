require 'rails_helper'

RSpec.describe Cms::ReferenceSystemsController, type: :controller do
  before :all do
    @available_locale = FactoryGirl.create(:available_locale, key: 'es')
    @admin_user = FactoryGirl.create(:admin_user, translator: true)
    @reference_system = FactoryGirl.create(:reference_system)
  end

  after :all do
    DatabaseCleaner.clean_with :truncation
  end

  before :each do
    sign_in(@admin_user, scope: :admin_user)
  end

  describe "sub-folder of available_locale" do
    describe "GET :index" do
      it "assigns locale and loads reference_systems" do
        get :index, params: { available_locale_id: @available_locale.to_param }

        expect(assigns(:available_locale)).to eq(@available_locale)
        expect(assigns(:reference_systems)).to include(@reference_system)
        expect(response).to render_template('cms/available_locales/reference_systems/index')
      end
    end

    describe "GET :show" do
      it "shows the reference_system" do
        get :show, params: { available_locale_id: @available_locale.to_param, id: @reference_system.to_param }

        expect(I18n.locale).to eq(@available_locale.key.to_sym)
        expect(assigns(:available_locale)).to eq(@available_locale)
        expect(assigns(:reference_system)).to eq(@reference_system)
        expect(response).to render_template('cms/available_locales/reference_systems/edit')
      end
    end

    describe "GET :edit" do
      it "assigns locale and reference_system and renders form" do
        get :edit, params: { available_locale_id: @available_locale.to_param, id: @reference_system.to_param }

        expect(I18n.locale).to eq(@available_locale.key.to_sym)
        expect(assigns(:available_locale)).to eq(@available_locale)
        expect(assigns(:reference_system)).to eq(@reference_system)
        expect(response).to render_template('cms/available_locales/reference_systems/edit')
      end
    end

    describe "PUT :update" do
      it "updates the reference_system" do
        put :update, params: {
          available_locale_id: @available_locale.to_param, id: @reference_system.to_param,
          reference_system: { description: 'New description' }
        }

        @reference_system.reload
        expect(@reference_system.description).to eq('New description')
        expect(response).to redirect_to cms_available_locale_reference_systems_path(@available_locale)
      end
    end
  end

end
