require 'rails_helper'

RSpec.describe Cms::ProductsController, type: :controller do
  before :all do
    @available_locale = FactoryBot.create(:available_locale, key: 'es')
    @admin_user = FactoryBot.create(:user, translator: true)
    @product = FactoryBot.create(:product)
  end

  after :all do
    DatabaseCleaner.clean_with :truncation
  end

  before :each do
    sign_in(@admin_user, scope: :user)
  end

  describe "sub-folder of available_locale" do
    describe "GET :index" do
      it "assigns locale and loads products" do
        get :index, params: { available_locale_id: @available_locale.to_param }

        expect(response).to render_template('cms/available_locales/products/index')
      end
    end

    describe "GET :show" do
      it "shows the product" do
        get :show, params: { available_locale_id: @available_locale.to_param, id: @product.to_param }

        expect(I18n.locale).to eq(@available_locale.key.to_sym)
        expect(response).to render_template('cms/available_locales/products/edit')
      end
    end

    describe "GET :edit" do
      it "assigns locale and product and renders form" do
        get :edit, params: { available_locale_id: @available_locale.to_param, id: @product.to_param }

        expect(I18n.locale).to eq(@available_locale.key.to_sym)
        expect(response).to render_template('cms/available_locales/products/edit')
      end
    end

    describe "PUT :update" do
      it "updates the product" do
        put :update, params: {
          available_locale_id: @available_locale.to_param, id: @product.to_param,
          product: { description: 'New description' }
        }

        @product.reload
        expect(@product.description).to eq('New description')
        expect(response).to redirect_to cms_available_locale_products_path(@available_locale)
      end
    end
  end

end
