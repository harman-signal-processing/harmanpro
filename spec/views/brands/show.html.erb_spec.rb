require "rails_helper"

RSpec.describe "brands/show", as: :view do

  before(:all) do
    @brand = FactoryBot.create(:brand,
                                marketing_url: 'http://foo.bar',
                                logo_collection: File.new(Rails.root.join('spec', 'fixtures', 'test.zip')),
                                by_harman_logo: File.new(Rails.root.join('spec', 'fixtures', 'test.jpg')),
                                description: "Super cool maker of widgets")
    assign(:brand, @brand)
  end

  before :each do
    render
  end

  it "shows the brand logo (by harman)" do
    expect(rendered).to match @brand.by_harman_logo.url(:large)
  end

  it "links to the brand external site" do
    expect(rendered).to have_link(@brand.friendly_url, href: @brand.url)
  end

  it "has the brand description" do
    expect(rendered).to have_content @brand.description
  end

  it "links to the logo collection" do
    expect(rendered).to have_link("#{ @brand.name } logo collection")
  end

  it "links to more marketing resources" do
    expect(rendered).to have_link('More marketing resources', href: @brand.marketing_url)
  end

end
