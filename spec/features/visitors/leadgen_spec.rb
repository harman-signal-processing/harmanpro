require "rails_helper"

class GoAcousticStub
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

    expect(Lead).to receive(:goacoustic_client).and_return(GoAcousticStub.new)
    expect_any_instance_of(GoAcousticStub).to receive(:add_recipient).and_return(true)
    complete_leadgen_form(lead)

    new_lead = Lead.last
    expect(page).to have_content(@title.content)
    expect(new_lead.name).to eq(lead.name)
    expect(new_lead.source).to eq(vertical_market_path(@vertical_market))
  end

  scenario "complete basic lead form" do
    lead = FactoryBot.build(:lead)
    visit new_lead_path

    expect(Lead).to receive(:goacoustic_client).and_return(GoAcousticStub.new)
    expect_any_instance_of(GoAcousticStub).to receive(:add_recipient).and_return(true)
    complete_leadgen_form(lead)

    new_lead = Lead.last
    expect(page).to have_content(@title.content)
    expect(new_lead.name).to eq(lead.name)
  end

  scenario "new lead is delivered to country lead recipient" do
    perform_enqueued_jobs do
      user = create(:user, admin: true)
      create(:country_lead_recipient, country: "US", user: user)
      lead = build(:lead, name: "Reference System Installer Lead")
      visit vertical_market_reference_system_path(@vertical_market, @reference_system)

      expect(Lead).to receive(:goacoustic_client).and_return(GoAcousticStub.new)
      expect_any_instance_of(GoAcousticStub).to receive(:add_recipient).and_return(true)
      complete_leadgen_form(lead)

      new_lead = Lead.last
      expect(page).to have_content(@title.content)
      expect(new_lead.name).to eq(lead.name)
      expect(new_lead.source).to eq(vertical_market_reference_system_path(@vertical_market, @reference_system))

      new_lead.update(recipient_id: 12345)
      last_email = ActionMailer::Base.deliveries.last
      expect(last_email.to).to include(user.email)
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

    expect(Lead).not_to receive(:goacoustic_client)
    expect_any_instance_of(GoAcousticStub).not_to receive(:add_recipient).and_return(true)
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
      select "United States", from: "Country"
      fill_in "Project Description", with: lead.project_description

      click_on "Submit"
    end
  end

end

