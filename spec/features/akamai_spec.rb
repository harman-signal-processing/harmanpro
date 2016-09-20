require "rails_helper"

feature "Sure route test object is fetched" do


  # Setting up /sureroute-test-object.html for akamai
  scenario "successfully" do
    visit "/sureroute-test-object.html"

    expect(current_path).to eq sureroute_test_object_path(format: :html)
    expect(page).to have_content "success"
  end

end
