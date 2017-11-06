require "rails_helper"

feature "Translators translate a brand" do

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
    expect(page).to have_link("Brands", href: cms_available_locale_brands_path(@locale))
  end

  scenario "translates a record" do
    brand = FactoryBot.create(:brand) # which means it needs translation

    visit cms_available_locale_path(@locale)
    click_on "Brands"
    click_on brand.name
    fill_in 'Description', with: "translated description for locale"
    click_on "Save"

    brand.reload
    I18n.locale = @locale.key.to_sym
    expect(brand.description).to eq("translated description for locale")

    I18n.locale = I18n.default_locale
    expect(brand.description).not_to eq("translated description for locale")

    expect(current_path).to eq(cms_available_locale_brands_path(@locale))
  end
end
