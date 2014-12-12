require 'rails_helper'

RSpec.describe "vertical_markets/_plan.html.erb", :type => :view do

  before do
    @vertical_market = FactoryGirl.create(:vertical_market)
    @reference_system = FactoryGirl.create(:reference_system, vertical_market: @vertical_market)
  end

  context "non-retail" do
    before do
      @parent_vertical_market = FactoryGirl.create(:vertical_market)
      @vertical_market.update_column(:parent_id, @parent_vertical_market.id)
      @reference_system.update_column(:retail, false)
      FactoryGirl.create(:site_setting, name: "hef-sidebar-title", content: "HEF Headline")
      FactoryGirl.create(:site_setting, name: "hef-description", content: "HEF description")
      FactoryGirl.create(:site_setting, name: "subheader-help-find-installer", content: "Help Me Find Installer")
      FactoryGirl.create(:site_setting, name: "help-find-installer-description", content: "Paragraph helping customer find installer.")
      FactoryGirl.create(:site_setting, name: "button-help-find-installer", content: "Help Me Find Installer")
      render partial: "vertical_markets/plan", locals: { vertical_market: @vertical_market }
    end

    it "shows HEF content" do
      expect(rendered).to have_css("h6", text: "HEF Headline")
      expect(rendered).to have_content("HEF description")
    end

    it "links to learn more about HEF" do
      pending "Determine where to link button for HEF"
      expect(rendered).to have_link("Learn More", href: "somewhere-to-learn-about-hef")
    end

    it "offers help finding contractor" do
      expect(rendered).to have_css("h6", text: "Help Me Find Installer")
      expect(rendered).to have_content("Paragraph helping customer find installer.")
    end

    it "links to help find contracter" do
      pending "Determine where to link button to find contractor"
      expect(rendered).to have_link("Help Me Find Installer", href: "somewhere-to-find-installer")
    end

    it "shows content from parent vertical" do
      expect(rendered).to have_css("h3", text: @parent_vertical_market.headline)
      expect(rendered).to have_content(@parent_vertical_market.description)
    end
  end

  context "retail" do
    before do
      @reference_system.update_column(:retail, true)
      render partial: "vertical_markets/plan", locals: { vertical_market: @vertical_market }
    end

    it "shows plan section for retail vertical market" do
      skip "Develop plan section for retail"
    end
  end

end