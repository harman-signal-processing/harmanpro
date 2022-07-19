require 'rails_helper'

RSpec.describe "landing_pages/show", type: :view do

  before :all do
    @landing_page = FactoryBot.create(:landing_page)
    assign(:landing_page, @landing_page)
  end

  before :each do
    render
  end

  it "has the title and content" do
    expect(rendered).to have_content @landing_page.title
    expect(rendered).to have_content @landing_page.main_content
  end
end
