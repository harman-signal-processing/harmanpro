require 'rails_helper'

RSpec.describe Cms::ProductTypesController, type: :controller do
  before :all do
    @available_locale = FactoryGirl.create(:available_locale, key: 'es')
    @admin_user = FactoryGirl.create(:admin_user, translator: true)
    @product_type = FactoryGirl.create(:product_type)
  end

  after :all do
    DatabaseCleaner.clean_with :truncation
  end

  before :each do
    sign_in(@admin_user, scope: :admin_user)
  end

  describe "sub-folder of available_locale" do
    describe "GET :index" do
      it "assigns locale and loads product_types" do
        get :index, params: { available_locale_id: @available_locale.to_param }

        expect(assigns(:available_locale)).to eq(@available_locale)
        expect(assigns(:product_types)).to include(@product_type)
        expect(response).to render_template('cms/available_locales/product_types/index')
      end
    end

    describe "GET :show" do
      it "shows the product_type" do
        get :show, params: { available_locale_id: @available_locale.to_param, id: @product_type.to_param }

        expect(I18n.locale).to eq(@available_locale.key.to_sym)
        expect(assigns(:available_locale)).to eq(@available_locale)
        expect(assigns(:product_type)).to eq(@product_type)
        expect(response).to render_template('cms/available_locales/product_types/edit')
      end
    end

    describe "GET :edit" do
      it "assigns locale and product_type and renders form" do
        get :edit, params: { available_locale_id: @available_locale.to_param, id: @product_type.to_param }

        expect(I18n.locale).to eq(@available_locale.key.to_sym)
        expect(assigns(:available_locale)).to eq(@available_locale)
        expect(assigns(:product_type)).to eq(@product_type)
        expect(response).to render_template('cms/available_locales/product_types/edit')
      end
    end

    describe "PUT :update" do
      it "updates the product_type" do
        put :update, params: {
          available_locale_id: @available_locale.to_param, id: @product_type.to_param,
          product_type: { description: 'New description' }
        }

        @product_type.reload
        expect(@product_type.description).to eq('New description')
        expect(response).to redirect_to cms_available_locale_product_types_path(@available_locale)
      end
    end
  end

end
