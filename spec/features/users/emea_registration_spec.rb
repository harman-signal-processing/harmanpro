require "rails_helper"

feature "EMEA Distributors registration" do

  before :all do
    @invitation_code = FactoryBot.create(
      :site_setting,
      name: "emea_distributor_invitation_code",
      content: "this-is-the-code"
    )

  end

  after :all do
    DatabaseCleaner.clean_with :truncation
  end

  before :each do
    visit emea_root_path
    click_on "Sign up"
  end

  scenario "successfully and gets correct role" do
    user = FactoryBot.build(:user)
    fill_in "Email", with: user.email
    fill_in "Password", with: "this-is-my-password"
    fill_in "Password confirmation", with: "this-is-my-password"
    fill_in "Invitation code", with: @invitation_code.value
    click_on "Sign up"

    expect(current_url).to match(emea_root_url)

    last_user = User.last
    expect(last_user.email).to eq(user.email)
    expect(last_user.emea_distributor?).to be(true)
  end

  scenario "unsuccessfully with wrong code" do
    user = FactoryBot.build(:user)
    fill_in "Email", with: user.email
    fill_in "Password", with: "this-is-my-password"
    fill_in "Password confirmation", with: "this-is-my-password"
    fill_in "Invitation code", with: "some-bad-code"
    click_on "Sign up"

    expect(current_url).not_to match(emea_root_url)
    expect(User.exists?(email: user.email)).to be(false)
  end
end
