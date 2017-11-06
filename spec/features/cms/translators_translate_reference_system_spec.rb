require "rails_helper"

feature "Translators translate a reference_system" do

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
    expect(page).to have_link("Reference Systems", href: cms_available_locale_reference_systems_path(@locale))
  end

  scenario "translates a record" do
    reference_system = FactoryBot.create(:reference_system) # which means it needs translation

    visit cms_available_locale_path(@locale)
    click_on "Reference Systems"
    click_on reference_system.name
    fill_in 'Description', with: "translated description for locale"
    click_on "Save"

    reference_system.reload
    I18n.locale = @locale.key.to_sym
    expect(reference_system.description).to eq("translated description for locale")

    I18n.locale = I18n.default_locale
    expect(reference_system.description).not_to eq("translated description for locale")

    expect(current_path).to eq(cms_available_locale_reference_systems_path(@locale))
  end
end
