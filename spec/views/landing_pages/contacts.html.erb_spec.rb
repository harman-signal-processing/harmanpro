require "rails_helper"

RSpec.describe "landing_pages/contacts.html.erb", as: :view do

  before :all do
    @brand1 = FactoryBot.create(:brand, support_url: "http://support.lvh.me")
    @brand2 = FactoryBot.create(:brand)
  end

  before do
    allow(view).to receive(:all_brands).and_return([@brand1, @brand2])

    render
  end

  it "renders support link" do
    expect(rendered).to have_link(@brand1.name, href: @brand1.support_url)
  end

  it "renders brand link when no support link is present" do
    expect(rendered).to have_link(@brand2.name, href: @brand2.url)
  end
end
