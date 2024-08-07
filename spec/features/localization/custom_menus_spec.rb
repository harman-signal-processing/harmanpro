require "rails_helper"

feature "Resources nav menu customization" do

  before :all do
    @locale = create(:available_locale, key: 'es')
    create(:menu_item, top_nav_name: "Resources", title: "nav.consultants", link: "/consultant", locale: nil)
  end

  scenario "default locale shows only default items" do
    visit root_path

    expect(page).to have_link I18n.t('nav.resources')
    expect(page).to have_link I18n.t('nav.consultants')
  end

  scenario "customized locale shows custom links under Resources" do
    menu_item = create(:menu_item,
                       locale: @locale,
                       title: "Tienda",
                       top_nav_name: "Resources",
                       link: "http://shop.harmanpro.com",
                       enabled: true,
                       new_tab: true)

    visit root_path(locale: @locale.key)

    expect(page).to have_link menu_item.title, href: menu_item.link
  end

  scenario "non-custom, non-default locale shows default mnenu" do
    visit root_path(locale: @locale.key)

    expect(page).to have_link I18n.t('nav.consultants')
  end

end
