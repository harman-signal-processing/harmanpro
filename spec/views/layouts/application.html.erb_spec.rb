require "rails_helper"

RSpec.describe "layouts/application", as: :view do

  before :all do
    @brand = FactoryBot.create(:brand)
    @vertical_market = FactoryBot.create(:vertical_market, parent_id: nil)
    @child_vertical = FactoryBot.create(:vertical_market, parent_id: @vertical_market.id)
  end

  before :each do
    allow(view).to receive(:all_brands).and_return([@brand])
  end

  describe "header" do
    before :each do
      render
    end

    it "has logo above top nav" do
      expect(rendered).to have_css("img#logo")
    end

    it "links to consultant portal" do
      expect(header).to have_link "Consultant Portal", href: consultant_portal_path
    end

    it "links to training page" do
      expect(header).to have_link "Training", href: training_path
    end

    it "links to the contacts page" do
      expect(header).to have_link "Contacts", href: contacts_path
    end

    it "doesn't link to top-level vertical markets (used to)" do
      expect(header).not_to have_link @vertical_market.name, href: vertical_market_path(@vertical_market)
    end

    it "links to child vertical markets (didn't used to)" do
      expect(header).to have_link @child_vertical.name
    end

    it "links to service page" do
      expect(header).to have_link "Service", href: service_path
    end
  end

  describe "custom locale menu" do
    before :each do
      @locale = FactoryBot.create(:available_locale, key: 'es')
      @menu_item = FactoryBot.create(:menu_item,
                                     locale: @locale,
                                     title: "Tienda",
                                     link: "http://shop.harmanpro.com",
                                     enabled: true,
                                     new_tab: true)
      I18n.locale = @locale.key

      render
    end

    after :each do
      I18n.locale = I18n.default_locale
    end

    it "links to custom link" do
      expect(header).to have_link @menu_item.title
    end

  end

  def header
    @header ||= Capybara.string(rendered).find("nav.top-bar")
  end

end
