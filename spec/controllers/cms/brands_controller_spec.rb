require "rails_helper"

RSpec.describe Cms::BrandsController do

  before :all do
    @available_locale = FactoryGirl.create(:available_locale, key: 'es')
    @admin_user = FactoryGirl.create(:admin_user, translator: true)
    @brand = FactoryGirl.create(:brand)
  end

  after :all do
    DatabaseCleaner.clean_with :truncation
  end

  before :each do
    sign_in(:admin_user, @admin_user)
  end

  describe "sub-folder of available_locale" do
    describe "GET :index" do
      it "assigns locale and loads brands" do
        get :index, available_locale_id: @available_locale.to_param

        expect(assigns(:available_locale)).to eq(@available_locale)
        expect(assigns(:brands)).to include(@brand)
        expect(response).to render_template('cms/available_locales/brands/index')
      end
    end

    describe "GET :show" do
      it "shows the brand" do
        get :show, available_locale_id: @available_locale.to_param, id: @brand.to_param

        expect(I18n.locale).to eq(@available_locale.key.to_sym)
        expect(assigns(:available_locale)).to eq(@available_locale)
        expect(assigns(:brand)).to eq(@brand)
        expect(response).to render_template('cms/available_locales/brands/show')
      end
    end

    describe "GET :edit" do
      it "assigns locale and brand and renders form" do
        get :edit, available_locale_id: @available_locale.to_param, id: @brand.to_param

        expect(I18n.locale).to eq(@available_locale.key.to_sym)
        expect(assigns(:available_locale)).to eq(@available_locale)
        expect(assigns(:brand)).to eq(@brand)
        expect(response).to render_template('cms/available_locales/brands/edit')
      end
    end

    describe "PUT :update" do
      it "updates the brand" do
        put :update, available_locale_id: @available_locale.to_param, id: @brand.to_param,
          brand: { description: 'New description' }

        @brand.reload
        expect(@brand.description).to eq('New description')
        expect(response).to redirect_to cms_available_locale_brand_path(@available_locale, @brand)
      end
    end
  end

end
