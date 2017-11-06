require "rails_helper"

RSpec.describe "landing_pages/training.html.erb", as: :view do

  before :all do
    @brand1 = FactoryBot.create(:brand, training_url: "http://training.lvh.me")
    @brand2 = FactoryBot.create(:brand)
  end

  before do
    allow(view).to receive(:all_brands).and_return([@brand1, @brand2])

    render
  end

  it "renders support link" do
    expect(rendered).to have_link(@brand1.name, href: @brand1.training_url)
  end

  it "does not show brand link when no training link is present" do
    expect(rendered).not_to have_link(@brand2.name)
  end
end
