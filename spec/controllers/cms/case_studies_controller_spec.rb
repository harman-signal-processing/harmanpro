require 'rails_helper'

RSpec.describe Cms::CaseStudiesController, type: :controller do
  before :all do
    @available_locale = FactoryGirl.create(:available_locale, key: 'es')
    @admin_user = FactoryGirl.create(:user, translator: true)
    @case_study = FactoryGirl.create(:case_study)
  end

  after :all do
    DatabaseCleaner.clean_with :truncation
  end

  before :each do
    sign_in(@admin_user, scope: :user)
  end

  describe "sub-folder of available_locale" do
    describe "GET :index" do
      it "assigns locale and loads case studies" do
        get :index, params: { available_locale_id: @available_locale.to_param }

        expect(assigns(:available_locale)).to eq(@available_locale)
        expect(assigns(:case_studies)).to include(@case_study)
        expect(response).to render_template('cms/available_locales/case_studies/index')
      end
    end

    describe "GET :show" do
      it "shows the case study" do
        get :show, params: { available_locale_id: @available_locale.to_param, id: @case_study.to_param }

        expect(I18n.locale).to eq(@available_locale.key.to_sym)
        expect(assigns(:available_locale)).to eq(@available_locale)
        expect(assigns(:case_study)).to eq(@case_study)
        expect(response).to render_template('cms/available_locales/case_studies/edit')
      end
    end

    describe "GET :edit" do
      it "assigns locale and case_study and renders form" do
        get :edit, params: { available_locale_id: @available_locale.to_param, id: @case_study.to_param }

        expect(I18n.locale).to eq(@available_locale.key.to_sym)
        expect(assigns(:available_locale)).to eq(@available_locale)
        expect(assigns(:case_study)).to eq(@case_study)
        expect(response).to render_template('cms/available_locales/case_studies/edit')
      end
    end

    describe "PUT :update" do
      it "updates the case_study" do
        put :update, params: {
          available_locale_id: @available_locale.to_param, id: @case_study.to_param,
          case_study: { description: 'New description' }
        }

        @case_study.reload
        expect(@case_study.description).to eq('New description')
        expect(response).to redirect_to cms_available_locale_case_studies_path(@available_locale)
      end
    end
  end

end
