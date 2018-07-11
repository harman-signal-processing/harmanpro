require "rails_helper"

feature "Visitor to training page" do

  before :all do
    @brand = FactoryBot.create(:brand, training_url: "http://training.lvh.me", show_on_training_page: true)
  end

  before :each do
    visit training_path
  end

  scenario "links to brand training page" do
    click_on "#{@brand.name} Training"

    expect(current_url).to match(@brand.training_url)
  end

end
