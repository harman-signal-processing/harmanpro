require "rails_helper"

RSpec.describe "service_centers/login.html.erb", as: :view do

  before :all do
    @brand = FactoryBot.create(:brand, name: "Multiple Word Brand", tech_url: "http://tech.foo.com")
  end

  before :each do
    allow(SiteSetting).to receive(:value).with('service-page-register-your-products-subheader').and_return("Register Your Products")
    allow(SiteSetting).to receive(:value).with('service-page-warranty-repair-subheader').and_return("Warranty Repair")
    allow(SiteSetting).to receive(:value).with('service-page-service-center-login-blurb').and_return("blurb...")
    allow(SiteSetting).to receive(:value).with('service-page-become-a-service-center-blurb').and_return("blurb...")
    allow(SiteSetting).to receive(:value).with('service-center-requirements').and_return("Service requirements...")
    # allow(SiteSetting).to receive(:value).with('service-page-become-a-service-center-subheader').and_return("Become a Service Center")
    allow(SiteSetting).to receive(:value).with('service-login-visit-brand-portals-subheader').and_return("Visit brands...")
    allow(SiteSetting).to receive(:value).with('service-page-service-center-get-started-blurb').and_return("Get started by...")
    allow(SiteSetting).to receive(:value).with('service-login-harman-pro-dealer-portal-subheader').and_return("Dealer Portal")
    allow(SiteSetting).to receive(:value).with('service-page-harman-pro-dealer-portal-blurb').and_return("blurb...")
    assign(:brands, [@brand])
    render
  end

  it "links to the brands' tech site" do
    expect(rendered).to have_link "Multiple Technical Resources", href: @brand.tech_url
  end

  it "links to the brands' website" do
    expect(rendered).to have_link "Multiple Website", href: @brand.url
  end

  # it "links to becoming a service center" do
  #   expect(rendered).to have_css "h3", text: "Become a Service Center"
  #   expect(rendered).to have_link "Apply Now", href: new_service_center_path
  # end
end
