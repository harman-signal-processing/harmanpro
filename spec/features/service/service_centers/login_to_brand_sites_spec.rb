require "rails_helper"

feature "Service centers log in to brand tech sites" do

  before :all do
    @brand = FactoryBot.create(:brand, tech_url: "http://tech.foo.com")
  end

  before do
    visit service_center_login_path
  end

  it "has links to brands' tech sites" do
    click_on "#{@brand.first_name} Technical Resources"

    expect(current_url).to match(@brand.tech_url)
  end

  it "has links to brands' public websites" do
    click_on "#{@brand.first_name} Website"

    expect(current_url).to match(@brand.url)
  end

  it "links to becoming a service center" do
    click_on "Apply Now"

    expect(current_path).to eq new_service_center_path
  end
end
