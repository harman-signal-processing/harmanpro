# Feature: Home page
#   As a visitor
#   I want to visit a home page
#   So I can learn more about the website
feature 'Service landing page' do

  before do
    visit service_path
  end

  # Scenario: Visit the home page
  #   Given I am a visitor
  #   When I visit the home page
  #   Then I see relevant sections
  scenario 'click through to warranty registration page' do
    click_on 'register-your-products'

    expect(current_url).to match(ENV['warranty_registration_url'])
  end

  scenario 'click through to dealer portal' do
    click_on 'Order Now'

    expect(current_url).to match(ENV['dealer_portal_url'])
  end

  scenario 'find a service center' do
    click_on "Find a Service Center"

    expect(current_path).to eq service_centers_path
  end

end
