require "rails_helper"

feature "Translators translate a product type" do

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
    expect(page).to have_link("Product Types", href: cms_available_locale_product_types_path(@locale))
  end

  scenario "translates a record" do
    product_type = FactoryGirl.create(:product_type) # which means it needs translation

    visit cms_available_locale_path(@locale)
    click_on "Product Types"
    click_on product_type.name
    fill_in 'Description', with: "translated description for locale"
    click_on "Save"

    product_type.reload
    I18n.locale = @locale.key.to_sym
    expect(product_type.description).to eq("translated description for locale")

    I18n.locale = I18n.default_locale
    expect(product_type.description).not_to eq("translated description for locale")

    expect(current_path).to eq(cms_available_locale_product_types_path(@locale))
  end
end
