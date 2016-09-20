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

  describe "deleting" do
    it "raises an error when related case studies exist" do
      case_study = FactoryGirl.create(:case_study)
      vertical_market = FactoryGirl.create(:vertical_market)
      vertical_market.case_studies << case_study

      vertical_market.destroy

      expect(VerticalMarket.exists?(vertical_market.id)).to be true
    end

    it "raises an error when related reference systems exist" do
      reference_system = FactoryGirl.create(:reference_system)
      vertical_market = reference_system.vertical_market

      vertical_market.destroy

      expect(VerticalMarket.exists?(vertical_market.id)).to be true
    end
  end

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
      case_studies = FactoryGirl.create_list(:case_study, 4)
      @child_vertical.case_studies += case_studies
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

    describe "#all_diagrams_present?" do
      it "is true if all its reference systems have diagrams" do
        reference_system = FactoryGirl.create(:reference_system, vertical_market: @child_vertical)
        reference_system.system_diagram = File.new(Rails.root.join('spec', 'fixtures', 'test.jpg'))
        reference_system.save

        @child_vertical.reload

        expect(reference_system.system_diagram.present?).to be(true)
        expect(@child_vertical.all_diagrams_present?).to be(true)
      end

      it "is false if any reference system don't have diagrams" do
        reference_system = FactoryGirl.create(:reference_system, vertical_market: @child_vertical)

        @child_vertical.reload

        expect(reference_system.system_diagram.present?).to be(false)
        expect(@child_vertical.all_diagrams_present?).to be(false)
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
