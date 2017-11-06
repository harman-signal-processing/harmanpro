require 'rails_helper'

RSpec.describe Cms::EventsController, type: :controller do
  before :all do
    @available_locale = FactoryBot.create(:available_locale, key: 'es')
    @admin_user = FactoryBot.create(:user, translator: true)
    @event = FactoryBot.create(:event)
  end

  after :all do
    DatabaseCleaner.clean_with :truncation
  end

  before :each do
    sign_in(@admin_user, scope: :user)
  end

  describe "sub-folder of available_locale" do
    describe "GET :index" do
      it "assigns locale and loads events" do
        get :index, params: { available_locale_id: @available_locale.to_param }

        expect(assigns(:available_locale)).to eq(@available_locale)
        expect(assigns(:events)).to include(@event)
        expect(response).to render_template('cms/available_locales/events/index')
      end
    end

    describe "GET :show" do
      it "shows the event" do
        get :show, params: { available_locale_id: @available_locale.to_param, id: @event.to_param }

        expect(I18n.locale).to eq(@available_locale.key.to_sym)
        expect(assigns(:available_locale)).to eq(@available_locale)
        expect(assigns(:event)).to eq(@event)
        expect(response).to render_template('cms/available_locales/events/edit')
      end
    end

    describe "GET :edit" do
      it "assigns locale and event and renders form" do
        get :edit, params: { available_locale_id: @available_locale.to_param, id: @event.to_param }

        expect(I18n.locale).to eq(@available_locale.key.to_sym)
        expect(assigns(:available_locale)).to eq(@available_locale)
        expect(assigns(:event)).to eq(@event)
        expect(response).to render_template('cms/available_locales/events/edit')
      end
    end

    describe "PUT :update" do
      it "updates the event" do
        put :update, params: {
          available_locale_id: @available_locale.to_param, id: @event.to_param,
          event: { description: 'New description' }
        }

        @event.reload
        expect(@event.description).to eq('New description')
        expect(response).to redirect_to cms_available_locale_events_path(@available_locale)
      end
    end
  end

end
