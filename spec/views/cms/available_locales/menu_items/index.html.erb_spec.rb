require "rails_helper"

RSpec.describe "cms/available_locales/menu_items/index.html.erb" do
  before :all do
    @locale = FactoryBot.create(:available_locale)
    @menu_item = FactoryBot.create(:menu_item, locale: @locale)
    @store_link = FactoryBot.create(:site_setting)
    @blog_link = FactoryBot.create(:site_setting)
    @blog_link_name = FactoryBot.create(:site_setting)
  end

  before :each do
    assign(:available_locale, @locale)
    assign(:store_link, @store_link)
    assign(:blog_link, @blog_link)
    assign(:blog_link_name, @blog_link_name)
    render
  end

  it "links to create menu item" do
    expect(rendered).to have_link("Add menu item",
                                  href: new_cms_available_locale_menu_item_path(@locale))
  end

  it "links to edit existing menu items" do
    expect(rendered).to have_link(@menu_item.title, href: edit_cms_available_locale_menu_item_path(@locale, @menu_item))
  end
end
