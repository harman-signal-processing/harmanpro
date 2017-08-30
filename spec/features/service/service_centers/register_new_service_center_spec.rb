require "rails_helper"

feature "Registering to become a service center" do
  include ActiveJob::TestHelper

  before :each do
    clear_enqueued_jobs
    @service_center = FactoryGirl.build(:service_center)

    visit new_service_center_path
  end

  scenario "successfully" do
    perform_enqueued_jobs do
      s_count = ServiceCenter.count

      fill_in_form(@service_center)
      click_on "Register"

      service_center = ServiceCenter.last
      expect(page).to have_content "Thank you"
      expect(current_path).to eq service_center_login_path
      expect(service_center.name).to eq @service_center.name
      expect(service_center.active?).to be false
      expect(ServiceCenter.count).to eq(s_count + 1)

      last_email = ActionMailer::Base.deliveries.last
      expect(last_email.to).to include(ENV['service_center_registration_recipient'])
    end
  end

  scenario "with errors" do
    @service_center.name = nil
    s_count = ServiceCenter.count

    fill_in_form(@service_center)
    click_on "Register"

    expect(ServiceCenter.count).to eq s_count
    expect(page).to have_content "can't be blank"
  end

  def fill_in_form(sc)
    within("form#new_service_center") do
      fill_in "Your Name", with: sc.contact_name
      fill_in "Business Name", with: sc.name
      fill_in "Address", with: sc.address
      fill_in "City", with: sc.city
      fill_in "State", with: sc.state
      fill_in "Postal Code", with: sc.zip
      fill_in "Phone", with: sc.phone
      fill_in "Email", with: sc.email
      check "I am willing and able to service all HARMAN" #...
    end
  end

end
