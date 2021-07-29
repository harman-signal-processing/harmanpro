require "rails_helper"

RSpec.describe "service/index.html.erb", as: :view do

  before do
    assign(:contact_message, ContactMessage.new)
    allow(SiteSetting).to receive(:value).with('service-page-service-center-login-subheader').and_return("Service Center Login")
    allow(SiteSetting).to receive(:value).with('service-page-service-center-login-blurb').and_return("blurb...")
    # allow(SiteSetting).to receive(:value).with('service-page-become-a-service-center-subheader').and_return("Become a Service Center")
    # allow(SiteSetting).to receive(:value).with('service-page-become-a-service-center-blurb').and_return("blurb...")
    allow(SiteSetting).to receive(:value).with('service-page-harman-pro-dealer-portal-subheader').and_return("Dealer Portal")
    allow(SiteSetting).to receive(:value).with('service-page-harman-pro-dealer-portal-blurb').and_return("blurb...")
    render
  end

  describe "support form" do

    it "exists" do
      expect(rendered).to have_css "form#new_contact_message"
    end

  end

  it "has service center login section" do
    expect(rendered).to have_css "h3", text: "Service Center Login"
    expect(rendered).to have_link "Access Now", href: service_center_login_path
  end

  # it "has section on becoming a service center" do
  #   expect(rendered).to have_css "h3", text: "Become a Service Center"
  #   expect(rendered).to have_link "Apply Now", href: new_service_center_path
  # end

  it "has dealer portal section" do
    expect(rendered).to have_css "h3", text: "Dealer Portal"
    expect(rendered).to have_link "Order Now", href: ENV['dealer_portal_url']
  end
end
