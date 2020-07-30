require 'rails_helper'

RSpec.describe Cms::MenuItemsController, type: :controller do
  before :all do
    @available_locale = FactoryBot.create(:available_locale, key: 'es')
    @admin_user = FactoryBot.create(:user, translator: true)
  end

  after :all do
    DatabaseCleaner.clean_with :truncation
  end

  before :each do
    sign_in(@admin_user, scope: :user)
  end

  describe "sub-folder of available_locale" do
    describe "GET :index" do
      it "assigns locale" do
        get :index, params: { available_locale_id: @available_locale.to_param }

        expect(response).to render_template('cms/available_locales/menu_items/index')
      end
    end

    describe "GET :new" do
      it "assigns locale and sets up new MenuItem" do
        get :new, params: { available_locale_id: @available_locale.to_param }

        expect(response).to render_template('cms/available_locales/menu_items/new')
      end
    end

    describe "POST :create" do
      it "creates the new menu item and assigns it the currently active locale" do
        post :create, params: {
          available_locale_id: @available_locale.to_param, menu_item: {
            title: "Cosa Buena", link: "http://cosabuena.com"
          }
        }

        expect(response).to redirect_to cms_available_locale_menu_items_path(@available_locale)
      end
    end

    describe "GET :edit" do
      before do
        @menu_item = FactoryBot.create(:menu_item, locale: @available_locale)
        get :edit, params: { available_locale_id: @available_locale.id, id: @menu_item.id }
      end

      it "renders a form to edit the menu item" do
        expect(response).to render_template("cms/available_locales/menu_items/edit")
      end
    end

    describe "PUT :update" do
      before do
        @menu_item = FactoryBot.create(:menu_item, locale: @available_locale)
      end

      it "updates the item" do
        put :update, params: {
          available_locale_id: @available_locale.id, id: @menu_item.id, menu_item: {
            title: "Foo To You", link: "http://foo.to.you"
          }
        }

        @menu_item.reload
        expect(@menu_item.title).to eq "Foo To You"
        expect(@menu_item.link).to eq "http://foo.to.you"
        expect(response).to redirect_to(cms_available_locale_menu_items_path(@available_locale))
      end
    end

  end

end
