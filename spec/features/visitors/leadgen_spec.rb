require "rails_helper"

class AcousticStub
  def add_recipient(user, db, list)
    true
  end
end

feature "Lead generation" do
  include ActiveJob::TestHelper

  before :all do
    @vertical_market = FactoryBot.create(:vertical_market, retail: false)
    @reference_system = FactoryBot.create(:reference_system, vertical_market: @vertical_market)
    @title = FactoryBot.create(:site_setting, name: "thanks", content: "Thanks!")
  end

  after :all do
    DatabaseCleaner.clean_with :truncation
  end

  # As a casual visitor on a vertical market page
  # I want to fill out a contact form
  # So that I can be contacted by sales
  scenario "complete installer help form on vertical market page" do
    lead = FactoryBot.build(:lead, name: "Vertical Market Installer Lead")
    visit vertical_market_path(@vertical_market)

    expect_any_instance_of(Lead).to receive(:acoustic_client).and_return(AcousticStub.new)
    expect_any_instance_of(AcousticStub).to receive(:add_recipient).and_return(true)
    complete_leadgen_form(lead)

    new_lead = Lead.last
    expect(page).to have_content(@title.content)
    expect(new_lead.name).to eq(lead.name)
    expect(new_lead.source).to eq(vertical_market_path(@vertical_market))
  end

  # As a casual visitor on a reference system page
  # I want to fill out a contact form
  # So that I can be contacted by sales
  scenario "complete installer help form on reference system page" do
    lead = FactoryBot.build(:lead, name: "Reference System Installer Lead")
    visit vertical_market_reference_system_path(@vertical_market, @reference_system)

    expect_any_instance_of(Lead).to receive(:acoustic_client).and_return(AcousticStub.new)
    expect_any_instance_of(AcousticStub).to receive(:add_recipient).and_return(true)
    complete_leadgen_form(lead)

    new_lead = Lead.last
    expect(page).to have_content(@title.content)
    expect(new_lead.name).to eq(lead.name)
    expect(new_lead.source).to eq(vertical_market_reference_system_path(@vertical_market, @reference_system))
  end

  scenario "new lead is delivered to sales department" do
    perform_enqueued_jobs do
      sales_recipients = FactoryBot.create(:site_setting, name: "leadgen-recipients", content: "yo@mama.com")
      lead = FactoryBot.build(:lead, name: "Reference System Installer Lead")
      visit vertical_market_reference_system_path(@vertical_market, @reference_system)

      expect_any_instance_of(Lead).to receive(:acoustic_client).and_return(AcousticStub.new)
      expect_any_instance_of(AcousticStub).to receive(:add_recipient).and_return(true)
      complete_leadgen_form(lead)

      new_lead = Lead.last
      expect(page).to have_content(@title.content)
      expect(new_lead.name).to eq(lead.name)
      expect(new_lead.source).to eq(vertical_market_reference_system_path(@vertical_market, @reference_system))

      last_email = ActionMailer::Base.deliveries.last
      expect(last_email.to).to include(sales_recipients.content)
    end
  end

  # As a casual visitor
  # I want to see error messages
  # When I incorrectly complete a leadgen form
  # So that I can correct my errors
  scenario "incorrectly complete installer help form" do
    lead_count = Lead.count
    lead = FactoryBot.build(:lead, name: nil, email: nil)
    visit vertical_market_path(@vertical_market)

    expect_any_instance_of(Lead).not_to receive(:acoustic_client).and_return(AcousticStub.new)
    expect_any_instance_of(AcousticStub).not_to receive(:add_recipient).and_return(true)
    complete_leadgen_form(lead)

    expect(page).to have_content("can't be blank")
    expect(Lead.count).to eq(lead_count)
  end

  def complete_leadgen_form(lead)
    within('form#new_lead') do
      fill_in "Name", with: lead.name
      fill_in "Company", with: lead.company
      fill_in "Email", with: lead.email
      fill_in "Phone", with: lead.phone
      fill_in "Location", with: lead.location
      fill_in "Project Description", with: lead.project_description

      click_on "Submit"
    end
  end

end
