# Feature: Home page
#   As a visitor
#   I want to visit a home page
#   So I can learn more about the website
feature 'Service landing page' do

  before do
    visit service_path
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
