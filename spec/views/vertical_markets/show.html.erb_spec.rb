require 'rails_helper'

describe "vertical_markets/show.html.erb" do
  context "parent vertical" do
    before :all do
      @vertical_market = FactoryGirl.create(:vertical_market, parent_id: nil)
      @child_verticals = FactoryGirl.create_list(:vertical_market, 3, parent_id: @vertical_market.id)
      @reference_system = FactoryGirl.create(:reference_system, vertical_market: @vertical_market)
      assign(:vertical_market, @vertical_market)
      assign(:lead, Lead.new)
      assign(:reference_systems, [])
    end

    before :each do
      render
    end

    it "links to child verticals" do
      @child_verticals.each do |vm|
        expect(rendered).to have_link(vm.name, href: vertical_market_path(vm))
      end
    end

    it "has the parent container" do
      expect(rendered).to have_css("div.parent-category-container")
    end

    it "does not link to applications" do
      expect(rendered).not_to have_link(@reference_system.name)
    end
  end

  context "general" do
    before :all do
      @vertical_market = FactoryGirl.create(:vertical_market)
      @reference_system = FactoryGirl.build_stubbed(:reference_system, vertical_market: @vertical_market)
      assign(:vertical_market, @vertical_market)
      assign(:lead, Lead.new)
      assign(:reference_systems, [@reference_system])
    end

    before :each do
      render
    end

    it "has headline and description" do
      expect(rendered).to have_css("h3", text: @vertical_market.headline)
      expect(rendered).to have_css("div.description", text: @vertical_market.description)
    end
  end

  context "bottom-level vertical" do
    before do
      @vertical_market = FactoryGirl.create(:vertical_market)
    end

    describe "and reference systems" do
      before do
        @reference_systems = FactoryGirl.create_list(:reference_system, 9, vertical_market: @vertical_market)
        assign(:lead, Lead.new)
        assign(:vertical_market, @vertical_market)

        render
      end

      context "noscript block" do

        it "shows only the first 6 reference systems" do
          reference_system = @reference_systems.last # (beyond the number we want to include)

          expect(rendered).not_to have_link(reference_system.headline, href: vertical_market_reference_system_path(@vertical_market, reference_system))
        end

        it "links to reference systems" do
          reference_system = @reference_systems.first

          expect(rendered).to have_link(reference_system.name, href: vertical_market_reference_system_path(@vertical_market, reference_system))
        end
      end

      it "shows the slider" do
        expect(rendered).to have_css("input[@slider]")
      end
    end

    describe "with only one reference system" do
      before do
        @reference_system = FactoryGirl.create(:reference_system, vertical_market: @vertical_market)
        assign(:vertical_market, @vertical_market)
        assign(:lead, Lead.new)

        render
      end

      it "does not show the slider" do
        expect(rendered).not_to have_css('slider')
      end
    end

    describe "and case studies" do
      before do
        @case_studies = FactoryGirl.create_list(:case_study, 4)
        @vertical_market.case_studies += @case_studies
        @reference_system = FactoryGirl.build_stubbed(:reference_system, vertical_market: @vertical_market)
        assign(:vertical_market, @vertical_market)
        assign(:lead, Lead.new)

        render
      end

      it "links to case studies" do
        case_study = @vertical_market.featured_case_studies.first

        expect(rendered).to have_link(case_study.headline, href: case_study_path(case_study))
      end
    end

  end

  context "child vertical" do
    before do
      @parent = FactoryGirl.create(:vertical_market)
      @vertical_market = FactoryGirl.create(:vertical_market, parent_id: @parent.id)
      @reference_system = FactoryGirl.build_stubbed(:reference_system, vertical_market: @vertical_market)
      assign(:vertical_market, @vertical_market)
      assign(:reference_systems, [@reference_system])
      assign(:lead, Lead.new)

      render
    end

    it "shows content from the parent vertical market" do
      expect(rendered).to have_css("h3", text: @parent.headline)
      expect(rendered).to have_css("div.parent", text: @parent.description)
    end
  end

end
