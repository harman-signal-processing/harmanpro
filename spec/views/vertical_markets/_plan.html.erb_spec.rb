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
      @vertical_market.update_column(:retail, false)
      FactoryGirl.create(:site_setting, name: "hef-sidebar-title", content: "HEF Headline")
      FactoryGirl.create(:site_setting, name: "hef-description", content: "HEF description")
      FactoryGirl.create(:site_setting, name: "subheader-help-find-installer", content: "Help Me Find Installer")
      FactoryGirl.create(:site_setting, name: "help-find-installer-description", content: "Paragraph helping customer find installer.")
      FactoryGirl.create(:site_setting, name: "button-help-find-installer", content: "Help Me Find Installer")
      FactoryGirl.create(:site_setting, name: "hef-link", content: "www.hef.com")
      render partial: "vertical_markets/plan", locals: { vertical_market: @vertical_market }
    end


    it "offers help finding contractor" do
      expect(rendered).to have_css("h4", text: "Help Me Find Installer")
      expect(rendered).to have_content("Paragraph helping customer find installer.")
    end

    it "links to help find contracter" do
      expect(rendered).to have_link("Help Me Find Installer", href: new_lead_path)
    end

    it "shows content from parent vertical" do
      expect(rendered).to have_css("h3", text: @parent_vertical_market.headline)
      expect(rendered).to have_content(@parent_vertical_market.description)
    end
  end

  context "retail" do
    before do
      FactoryGirl.create(:site_setting, name: "retail-plan-section-subheader", content: "How To Buy Stuff")
      FactoryGirl.create(:site_setting, name: "retail-plan-section-paragraph", content: "Paragraph on buying stuff")
      @vertical_market.update_column(:retail, true)

      render partial: "vertical_markets/plan", locals: { vertical_market: @vertical_market }
    end

    it "shows plan section for retail vertical market" do
      expect(rendered).to have_content("How To Buy Stuff")
      expect(rendered).to have_content("Paragraph on buying stuff")
    end
  end

end
