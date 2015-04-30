require 'rails_helper'

RSpec.describe VerticalMarket, :type => :model do

  before :all do
    @vertical_market = FactoryGirl.create(:vertical_market, parent_id: nil)
    @child_vertical = FactoryGirl.create(:vertical_market, parent_id: @vertical_market.id)
  end

  subject { @child_vertical }
  it { should respond_to(:name) }
  it { should respond_to(:headline) }
  it { should respond_to(:description) }
  it { should respond_to(:retail?) }
  it { should respond_to(:parent) }
  it { should respond_to(:reference_systems) }
  it { should respond_to(:case_studies) }
  it { should respond_to(:banner) }
  it { should respond_to(:friendly_id) }

  context "class methods" do
    it "#parent_verticals should return all the parent verticals" do
      parents = VerticalMarket.parent_verticals

      expect(parents).to include(@vertical_market)
      expect(parents).not_to include(@child_vertical)
    end
  end

  context "instance methods" do
    it "has a parent" do
      expect(@child_vertical.parent).to eq(@vertical_market)
    end

    it "has children" do
      expect(@vertical_market.children).to include(@child_vertical)
    end

    it "has reference_systems" do
      reference_system = FactoryGirl.create(:reference_system, vertical_market: @child_vertical)

      @child_vertical.reload

      expect(@child_vertical.reference_systems).to include(reference_system)
    end

    it "#featured_reference_systems limits them to 6" do
      FactoryGirl.create_list(:reference_system, 7, vertical_market: @child_vertical)
      @child_vertical.reload

      expect(@child_vertical.featured_reference_systems.length).to eq(6)
    end

    it "#featured_case_studies is limited to 3" do
      FactoryGirl.create_list(:case_study, 4, vertical_market: @child_vertical)
      @child_vertical.reload

      expect(@child_vertical.featured_case_studies.length).to eq(3)
    end

    describe ".retail?" do
      it "is true if it has any reference systems which are retail" do
        FactoryGirl.create(:reference_system, vertical_market: @child_vertical, retail: true)

        expect(@child_vertical.retail?).to be(true)
      end

      it "is false if it has no reference systems which are retail" do
        expect(@child_vertical.retail?).to be(false)
      end
    end
  end

  describe "friendly id" do
    it "generates a new slug when name changes" do
      old_slug = @vertical_market.slug

      @vertical_market.name = "Yo Mama #{@vertical_market.name}"
      @vertical_market.save
      @vertical_market.reload

      expect(@vertical_market.slug).not_to eq old_slug
      expect(@vertical_market.slug.present?).to be(true)
    end
  end
end
