require 'rails_helper'

RSpec.describe EmeaPage, type: :model do

  before :all do
    @page = FactoryGirl.create(:emea_page)
    @resource = FactoryGirl.create(:emea_page_resource, emea_page: @page)
  end

  subject { @page }
  it { should respond_to(:title) }
  it { should respond_to(:resources) }

  it "resources are EmeaPageResource" do
    expect(@page.resources).to include(@resource)
    expect(@page.resources.first).to be_an(EmeaPageResource)
  end

  context "class methods" do
    it ".home should find or generate a homepage" do
      page = EmeaPage.home
      expect(page).to be_an(EmeaPage)
      expect(page.title).to eq("Home")
    end

    it ".for_top_nav should return a list of topnav pages" do
      published_page = FactoryGirl.create(:emea_page, publish_on: 1.year.ago, position: 1)
      unpublished_page = FactoryGirl.create(:emea_page, publish_on: 1.year.from_now, position: 2)

      top_nav = EmeaPage.for_top_nav

      expect(top_nav).to include(published_page)
      expect(top_nav).not_to include(unpublished_page)
    end
  end

  it "has features" do
    feature = FactoryGirl.create(:emea_page_resource, featured: true)
    page = feature.emea_page

    expect(page.features).to include(feature)
  end
end
