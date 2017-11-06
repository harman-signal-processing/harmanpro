require "rails_helper"

feature "EMEA Distributors logout" do

  before :all do
    @password = "ABCD1234"
    @distributor = FactoryBot.create(:user,
                                      emea_distributor: true,
                                      password: @password,
                                      password_confirmation: @password)
  end

  before :each do
    visit emea_root_path
    fill_in "Email", with: @distributor.email
    fill_in "Password", with: @password
    click_on "Log in"
  end

  scenario "click logout, redirect to root path" do
    click_on "Sign Out"

    expect(current_path).to eq(root_path)
  end
end
