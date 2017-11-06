require "rails_helper"

RSpec.describe "cms/available_locales/site_settings/index.html.erb" do

  before :all do
    @site_setting = FactoryBot.create(:site_setting)
    @locale = FactoryBot.create(:available_locale)
  end

  before :each do
    assign(:available_locale, @locale)
    assign(:site_settings, SiteSetting.all)
    render
  end

  it "links to edit the site setting" do
    expect(rendered).to have_link(@site_setting.name, href: edit_cms_available_locale_site_setting_path(@locale, @site_setting))
  end
end
