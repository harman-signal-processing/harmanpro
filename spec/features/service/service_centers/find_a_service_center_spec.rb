require "rails_helper"

feature "Find a service center" do

  before :all do
    skip "It seems this functionality was removed 2024-07"
    @service_group = FactoryBot.create(:service_group)
    @service_center = FactoryBot.create(:service_center)
    @service_center.service_groups << @service_group
  end

  before :each do
    visit service_centers_path
  end

  scenario "by state only" do
    select @service_center.state, from: "Select your state"
    select "(any)", from: "Service type needed"
    click_on "Search"

    expect(page).to have_content(@service_center.name)
  end

  scenario "by state and service type" do
    select @service_center.state, from: "Select your state"
    select @service_group.name, from: "Service type needed"
    click_on "Search"

    expect(page).to have_content(@service_center.name)
    expect(page).to have_content(@service_group.name)
  end

  scenario "by service type only" do
    select "(any)", from: "Select your state"
    select @service_group.name, from: "Service type needed"
    click_on "Search"

    expect(page).to have_content(@service_center.name)
    expect(page).to have_content(@service_group.name)
  end
end
