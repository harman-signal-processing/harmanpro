require "rails_helper"

RSpec.describe "service_centers/_form", as: :view do

  before :each do
    assign(:service_center, ServiceCenter.new)

    render
  end

  it "has the required fields" do
    expect(rendered).to have_css("input[@id='service_center_contact_name']")
    expect(rendered).to have_css("input[@id='service_center_name']")
    expect(rendered).to have_css("input[@id='service_center_zip']")
    expect(rendered).to have_css("input[@id='service_center_email']")
    expect(rendered).to have_css("input[@id='service_center_willingness']")
    expect(rendered).to have_css("input[@type='submit']")
  end
end
