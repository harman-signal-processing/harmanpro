require "rails_helper"

feature "Basic visitor flow" do

  before :all do
    @brand = FactoryBot.create(:brand)
    @service_brand = FactoryBot.create(:brand, show_on_main_site: false)
    @parent_vertical = FactoryBot.create(:vertical_market)
    @child_vertical = FactoryBot.create(:vertical_market, parent_id: @parent_vertical.id)
    @reference_system = FactoryBot.create(:reference_system, vertical_market: @child_vertical)
    @case_study = FactoryBot.create(:case_study)
    @child_vertical.case_studies << @case_study
  end

  before :each do
    visit root_path
  end

  scenario "Visit brand information page" do
    click_on @brand.name

    expect(current_path).to eq brand_path(@brand)
  end

  scenario "Service-only brand does not appear" do
    expect(page).not_to have_link(@service_brand.name)
  end

  scenario "Service-only brand does not navigate" do
    visit brand_path(@service_brand)

    expect(current_path).to eq root_path
  end

  # As a casual visitor
  # I want to click on a vertical market
  # So I can navigate to its solutions
  scenario "Visit a parent vertical market page" do
    #click_on @parent_vertical.name # 8/2017 no longer featured on homepage
    visit vertical_market_path(@parent_vertical)

    expect(page).to have_link(@child_vertical.name, href: vertical_market_path(@child_vertical))
  end

  # As a casual visitor on a parent vertical market page
  # I want to click through to a child vertical market page
  # So I can find out about the system solutions
  scenario "Visit a child vertical market page" do
    #click_on @parent_vertical.name # 8/2017 no longer featured on homepage
    visit vertical_market_path(@parent_vertical)

    click_on @child_vertical.name

    expect(page).to have_link(@reference_system.name, href: vertical_market_reference_system_path(@child_vertical, @reference_system))
    expect(page).to have_link(@case_study.headline, href: case_study_path(@case_study))
  end

  # As a casual visitor
  # I want to land directly on a reference page
  # So I can learn directly about that system
  scenario "Visit a reference system page" do
    visit vertical_market_reference_system_path(@child_vertical, @reference_system)

    expect(page).to have_content(@reference_system.description)
  end

  # As a casual visitor on a vertical market page which has case studies
  # I want to click on a case study
  # So that I can read about it
  scenario "Visit a case study page" do
    visit vertical_market_path(@child_vertical)

    click_on @case_study.headline

    expect(page).to have_content(@case_study.content)
  end

end
