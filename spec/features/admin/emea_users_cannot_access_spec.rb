require "rails_helper"

feature "EMEA Distributors cannot access /admin" do

  before :all do
    @password = "ABCD1234"
    @distributor = FactoryBot.create(:user,
                                      emea_distributor: true,
                                      password: @password,
                                      password_confirmation: @password)
  end

  scenario "when logged in cannot jump to /admin" do
    visit emea_root_path

    fill_in "Email", with: @distributor.email
    fill_in "Password", with: @password
    click_on "Log in"

    expect(current_path).to eq(emea_root_path)

    visit "/admin"
    expect(current_path).not_to eq("/admin")
    expect(current_path).to eq(root_path)
  end

  scenario "not logged in, then logged in, are redirected to root instead of /admin" do
    visit '/admin'

    fill_in "Email", with: @distributor.email
    fill_in "Password", with: @password
    click_on "Log in"

    expect(current_path).not_to eq("/admin")
    expect(current_path).to eq(root_path)
  end

end
