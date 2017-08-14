require "rails_helper"

feature "Translators login" do

  before :each do
    @translator = FactoryGirl.create(:user, translator: true)
  end

  scenario "sees dashboard after signing in" do
    visit cms_root_path
    signin(@translator.email, @translator.password)

    expect(page).to have_content "Welcome"
    expect(current_path).to eq cms_root_path
  end
end
