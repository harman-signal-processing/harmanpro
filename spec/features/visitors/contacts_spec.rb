require "rails_helper"

feature "Visitor to contact page" do

  before :all do
    @brand = FactoryBot.create(:brand, support_url: "http://support.lvh.me")
  end

  before :each do
    visit contacts_path
  end

  scenario "links to brand support page" do
    click_on "#{@brand.name} Support"

    expect(current_url).to match(@brand.support_url)
  end

end
