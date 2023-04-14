require 'rails_helper'

RSpec.describe CaseStudy, :type => :model do
  before :all do
    case_study_vertical_market = FactoryBot.create(:case_study_vertical_market)
    @case_study = case_study_vertical_market.case_study
  end

  subject { @case_study }
  it { should respond_to(:vertical_markets) }
  it { should respond_to(:friendly_id) }
  it { should respond_to(:banner) }
  it { should respond_to(:case_study_images) }
  it { should respond_to(:name) } # alias for headline for backwards compat

  describe "friendly id" do
    it "generates a new slug when name changes" do
      old_slug = @case_study.slug

      @case_study.headline = "Yo Mama #{@case_study.headline}"
      @case_study.save
      @case_study.reload

      expect(@case_study.slug).not_to eq old_slug
    end

    it "generates a new slug when name changes" do
      old_slug = @case_study.slug

      @case_study.headline = "Yo Mama #{@case_study.headline}"
      @case_study.save
      @case_study.reload

      expect(@case_study.slug).not_to eq old_slug
      expect(@case_study.slug.present?).to be(true)
    end
  end

  it "#name should be the headline" do
    expect(@case_study.name).to eq(@case_study.headline)
  end

  it ".featured should choose good case studies to feature on the homepage" do
    inactive_vertical = FactoryBot.create(:vertical_market, live: false)
    inactive_study = FactoryBot.create(:case_study)
    inactive_vertical.case_studies << inactive_study

    featured = CaseStudy.featured

    expect(featured).to include(@case_study)
    expect(featured).not_to include(inactive_study)
  end
end

