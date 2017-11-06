require 'rails_helper'

RSpec.describe "vertical_markets/_learn.html.erb", :type => :view do

  before :all do
    @vertical_market = FactoryBot.create(:vertical_market, show_hef: true)
    csvm = FactoryBot.create(:case_study_vertical_market, vertical_market: @vertical_market)
    @case_study = csvm.case_study
    @reference_system = FactoryBot.create(:reference_system, vertical_market: @vertical_market)
  end

  before :each do
    render partial: "vertical_markets/learn", locals: { vertical_market: @vertical_market }
  end

  it "shows vertical market description and headline" do
    expect(rendered).to have_css("h3", text: @vertical_market.headline)
    expect(rendered).to have_content(@vertical_market.description)
  end

  it "links to case studies" do
    #expect(rendered).to have_xpath("//img[@src='#{@case_study.banner.url(:small)}']")
    expect(rendered).to have_link(@case_study.headline, href: case_study_path(@case_study))
  end

  context "non-retail" do
    before do
      @parent_vertical_market = FactoryBot.create(:vertical_market)
      @vertical_market.update_column(:parent_id, @parent_vertical_market.id)
      @vertical_market.update_column(:retail, false)
      FactoryBot.create(:site_setting, name: "hef-sidebar-title", content: "HEF Headline")
      FactoryBot.create(:site_setting, name: "hef-description", content: "HEF description")
      FactoryBot.create(:site_setting, name: "subheader-help-find-installer", content: "Help Me Find Installer")
      FactoryBot.create(:site_setting, name: "help-find-installer-description", content: "Paragraph helping customer find installer.")
      FactoryBot.create(:site_setting, name: "button-help-find-installer", content: "Help Me Find Installer")
      FactoryBot.create(:site_setting, name: "hef-link", content: "www.hef.com")
      render partial: "vertical_markets/learn", locals: { vertical_market: @vertical_market }
    end

    it "shows HEF content" do
      expect(rendered).to have_css("h4", text: "HEF Headline")
      expect(rendered).to have_content("HEF description")
    end

    it "links to learn more about HEF" do
      expect(rendered).to have_link("Learn More", href: "www.hef.com")
    end
  end

end
