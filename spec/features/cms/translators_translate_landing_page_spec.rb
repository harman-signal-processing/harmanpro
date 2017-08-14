require "rails_helper"

feature "Translators translate a landing page" do

  before :all do
    @translator = FactoryGirl.create(:user, translator: true)
    @locale = FactoryGirl.create(:available_locale, key: 'es')
    @translator.locales << @locale
  end

  after :all do
    DatabaseCleaner.clean_with :truncation
  end

  before :each do
    visit cms_root_path
    signin(@translator.email, @translator.password)
  end

  scenario "navigates to translation page for assigned locale" do
    visit cms_root_path

    click_on 'start translating'

    expect(current_path).to eq(cms_available_locale_path(@locale))
    expect(page).to have_link("Landing Pages", href: cms_available_locale_landing_pages_path(@locale))
  end

  scenario "translates a record" do
    landing_page = FactoryGirl.create(:landing_page) # which means it needs translation

    visit cms_available_locale_path(@locale)
    within '#translatables' do
      click_on "Landing Pages"
    end
    click_on landing_page.title
    fill_in 'Main content', with: "translated description for locale"
    click_on "Save"

    landing_page.reload
    I18n.locale = @locale.key.to_sym
    expect(landing_page.main_content).to eq("translated description for locale")

    I18n.locale = I18n.default_locale
    expect(landing_page.main_content).not_to eq("translated description for locale")

    expect(current_path).to eq(cms_available_locale_landing_pages_path(@locale))
  end
end
