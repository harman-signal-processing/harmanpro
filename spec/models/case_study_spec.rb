require 'rails_helper'

RSpec.describe CaseStudy, :type => :model do
  before :all do
    @case_study = FactoryGirl.create(:case_study)
  end

  subject { @case_study }
  it { should respond_to(:vertical_market) }
  it { should respond_to(:friendly_id) }
  it { should respond_to(:banner) }
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
    inactive_vertical = FactoryGirl.create(:vertical_market, live: false)
    inactive_study = FactoryGirl.create(:case_study, vertical_market: inactive_vertical)

    featured = CaseStudy.featured

    expect(featured).to include(@case_study)
    expect(featured).not_to include(inactive_study)
  end
end

