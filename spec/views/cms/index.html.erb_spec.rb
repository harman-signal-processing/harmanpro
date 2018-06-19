require "rails_helper"

RSpec.describe "cms/index.html.erb" do

  before :all do
    @translator = FactoryBot.create(:user, translator: true)
    @locale = FactoryBot.create(:available_locale)
    @translator.locales << @locale
  end

  before :each do
    allow(view).to receive(:current_user).and_return(@translator)
    render
  end

  it "says welcome" do
    expect(rendered).to have_content("Welcome")
  end

  it "shows translations needed for locale corresponding to user" do
    expect(rendered.to_s.gsub(/\s+/, ' ')).to have_text("items to be translated for #{ @locale.name}")
    expect(rendered).to have_link "start translating", href: cms_available_locale_path(@locale)
  end

  it "has a div with more tools for the locale" do
    expect(rendered).to have_css("##{ @locale.key }_tools")
    expect(rendered).to have_link("Customize Navigation", href: "/cms/available_locales/#{@locale.key}/menu_items")
  end

end
