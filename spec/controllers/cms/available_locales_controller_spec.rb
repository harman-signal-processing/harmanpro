require "rails_helper"

RSpec.describe Cms::AvailableLocalesController do

  before :all do
    @available_locale = FactoryBot.create(:available_locale, key: 'es')
    @admin_user = FactoryBot.create(:user, translator: true)
  end

  before :each do
    sign_in(@admin_user, scope: :user)
  end

  after :all do
    DatabaseCleaner.clean_with :truncation
  end

  describe "GET :show" do

    it "assigns @available_locale and renders template" do
      get :show, params: { id: @available_locale.to_param }

      expect(response).to render_template('cms/available_locales/show')
    end
  end

end
