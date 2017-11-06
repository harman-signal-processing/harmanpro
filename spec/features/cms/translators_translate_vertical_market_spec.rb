require "rails_helper"

feature "Translators translate a vertical_market" do

  before :all do
    @translator = FactoryBot.create(:user, translator: true)
    @locale = FactoryBot.create(:available_locale, key: 'es')
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
    expect(page).to have_link("Vertical Markets", href: cms_available_locale_vertical_markets_path(@locale))
  end

  scenario "translates a record" do
    vertical_market = FactoryBot.create(:vertical_market) # which means it needs translation

    visit cms_available_locale_path(@locale)
    click_on "Vertical Markets"
    click_on vertical_market.name
    fill_in 'Description', with: "translated description for locale"
    click_on "Save"

    vertical_market.reload
    I18n.locale = @locale.key.to_sym
    expect(vertical_market.description).to eq("translated description for locale")

    I18n.locale = I18n.default_locale
    expect(vertical_market.description).not_to eq("translated description for locale")

    expect(current_path).to eq(cms_available_locale_vertical_markets_path(@locale))
  end
end
