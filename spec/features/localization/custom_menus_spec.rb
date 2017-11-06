require "rails_helper"

feature "Resources nav menu customization" do

  before :all do
    @locale = FactoryBot.create(:available_locale, key: 'es')
  end

  scenario "default locale shows only default items" do
    visit root_path

    expect(page).to have_link I18n.t('nav.resources')
    expect(page).to have_link I18n.t('nav.consultants')
  end

  scenario "customized locale shows only custom links under Resources" do
    menu_item = FactoryBot.create(:menu_item,
                                   locale: @locale,
                                   title: "Tienda",
                                   link: "http://shop.harmanpro.com",
                                   enabled: true,
                                   new_tab: true)

    visit root_path(locale: @locale.key)

    expect(page).to have_link menu_item.title, href: menu_item.link
    expect(page).not_to have_link I18n.t('nav.consultants')
  end

  scenario "non-custom, non-default locale shows default mnenu" do
    visit root_path(locale: @locale.key)

    expect(page).to have_link I18n.t('nav.consultants')
  end

end
