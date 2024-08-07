require "rails_helper"

feature "Translators and admins can customize menus for their locale" do

  before :all do
    @translator = FactoryBot.create(:user, translator: true)
    @locale = FactoryBot.create(:available_locale, key: 'es')
    @menu_item = FactoryBot.create(:menu_item, locale: @locale)
    FactoryBot.create(:site_setting, name: "blog_link_name")
    FactoryBot.create(:site_setting, name: "blog_link")
    FactoryBot.create(:site_setting, name: "store_link")
    @translator.locales << @locale
    I18n.locale = @locale.key
  end

  after :all do
    DatabaseCleaner.clean_with :truncation
    I18n.locale = I18n.default_locale
  end

  before :each do
    visit cms_root_path
    signin(@translator.email, @translator.password)
    within "##{@locale.key}_tools" do
      click_on "Customize Navigation"
    end
  end

  scenario "adds menu item successfully" do
    click_on "Add menu item"

    fill_in "Parent menu", with: "Resources"
    fill_in "menu_item_title", with: "Cosa Maravillosa"
    fill_in "menu_item_link", with: "http://cosamaravillosa.com"
    click_on "Save Changes"

    visit root_path(locale: @locale.key)
    expect(page).to have_link "Cosa Maravillosa", href: "http://cosamaravillosa.com"
  end

  scenario "edits existing menu item successfully" do
    click_on @menu_item.title

    fill_in "Parent menu", with: "Resources"
    fill_in "menu_item_title", with: "Nuevo Link"
    fill_in "menu_item_link", with: "http://nuevo/"
    click_on "Save Changes"

    visit root_path(locale: @locale.key)
    expect(page).to have_link "Nuevo Link", href: "http://nuevo/"
  end

end
