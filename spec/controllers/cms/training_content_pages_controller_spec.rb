require 'rails_helper'

RSpec.describe Cms::TrainingContentPagesController, type: :controller do
  before :all do
    FactoryGirl.create(:available_locale, key: I18n.default_locale.to_s)
    @available_locale = FactoryGirl.create(:available_locale, key: 'es')
    @admin_user = FactoryGirl.create(:user, translator: true)
    @training_content_page = FactoryGirl.create(:training_content_page)
  end

  after :all do
    DatabaseCleaner.clean_with :truncation
  end

  before :each do
    sign_in(@admin_user, scope: :user)
  end

  describe "sub-folder of available_locale" do
    describe "GET :index" do
      it "assigns locale and loads training content pages" do
        get :index, params: { available_locale_id: @available_locale.to_param }

        #expect(assigns(:available_locale)).to eq(@available_locale)
        #expect(assigns(:training_content_page)).to include(@training_content_page)
        #expect(response).to render_template('cms/available_locales/training_content_pages/index')
      end
    end  #  describe "GET :index" do

    #describe "GET :show" do
    #  it "shows the training content page" do
    #    get :show, available_locale_id: @available_locale.to_param, id: @training_content_page.to_param

    #    expect(I18n.locale).to eq(@available_locale.key.to_sym)
    #    expect(assigns(:available_locale)).to eq(@available_locale)
    #    expect(assigns(:training_content_page)).to eq(@training_content_page)
    #    expect(response).to render_template('cms/available_locales/training_content_pages/edit')
    #  end
    #end  #  describe "GET :show" do

    #describe "GET :edit" do
    #  it "assigns locale and training_content_page and renders form" do
    #    get :edit, available_locale_id: @available_locale.to_param, id: @training_content_page.to_param

    #    expect(I18n.locale).to eq(@available_locale.key.to_sym)
    #    expect(assigns(:available_locale)).to eq(@available_locale)
    #    expect(assigns(:training_content_page)).to eq(@training_content_page)
    #    expect(response).to render_template('cms/available_locales/training_content_pages/edit')
    #  end
    #end  #  describe "GET :edit" do

    #describe "PUT :update" do
    #  it "updates the training_content_page" do
    #    put :update, available_locale_id: @available_locale.to_param, id: @training_content_page.to_param,
    #      training_content_page: { description: 'New description' }

    #    @training_content_page.reload
    #    expect(@training_content_page.description).to eq('New description')
    #    expect(response).to redirect_to cms_available_locale_training_content_pages_path(@available_locale)
    #  end
    #end  #  describe "PUT :update" do

  end  #  describe "sub-folder of available_locale" do

end  #  RSpec.describe Cms::TrainingContentPagesController, type: :controller do
