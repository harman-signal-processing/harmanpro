require "rails_helper"

feature "Translators translate a case study" do

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
    expect(page).to have_link("Case Studies", href: cms_available_locale_case_studies_path(@locale))
  end

  scenario "translates a record" do
    case_study = FactoryGirl.create(:case_study) # which means it needs translation

    visit cms_available_locale_path(@locale)
    click_on "Case Studies"
    click_on case_study.headline
    fill_in 'Headline', with: "A new title"
    fill_in 'Description', with: "translated description for locale"
    click_on "Save"

    case_study.reload
    I18n.locale = @locale.key.to_sym
    expect(case_study.description).to eq("translated description for locale")
    expect(case_study.slug).to eq("a-new-title")

    I18n.locale = I18n.default_locale
    expect(case_study.description).not_to eq("translated description for locale")
    expect(case_study.slug).not_to eq("a-new-title")

    expect(current_path).to eq(cms_available_locale_case_studies_path(@locale))
  end
end
