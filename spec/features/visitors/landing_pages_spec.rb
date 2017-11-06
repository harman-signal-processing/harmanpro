require "rails_helper"

feature "Landing pages" do

  before :all do
    @landing_page = FactoryBot.create(:landing_page)
  end

  before :each do
    visit landing_page_path(@landing_page)
  end

  scenario "it has the content" do
    expect(page).to have_content(@landing_page.main_content)
  end

end
