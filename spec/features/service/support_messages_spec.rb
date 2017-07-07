feature 'completing support form' do

  before :all do
    @brand = FactoryGirl.create(:brand)
  end

  before :each do
    skip "ng-switch doesn't render the page right for testing"
    visit service_path
  end

  scenario 'empty form' do
    click_on "Submit Message"
    expect(current_path).to eq service_path
  end

  describe '(tech support)', js: true do

    scenario 'successfully' do
      skip "ng-switch doesn't render the page right for testing"
      fill_in "Name", with: "Joey"
      fill_in "Email", with: "joey@joey.com"
      choose "Technical Support"
      select @brand.name, from: "Brand of Your Product"
      fill_in "Product Model", with: "CoolThing 5000"
      fill_in "Product serial number", with: "12345"
      select "United States"
      fill_in "Detailed problem description", with: "How do you work this thing?"

      click_on "Submit Message"
      expect(page).to have_text('contact-thankyou-message')
    end

  end

  describe '(parts request)', js: true do

    scenario 'successfully' do
      skip "ng-switch doesn't render the page right for testing"
      fill_in "Name", with: "Joey"
      fill_in "Email", with: "joey@joey.com"
      choose "Product Parts"
      fill_in "Company Name", with: "ACME"
      fill_in "HARMAN Account Number", with: "493475934"
      select @brand.name, from: "Brand of Your Product"
      fill_in "Product Model", with: "CoolThing 5000"
      fill_in "Address (No P.O. Boxes)", with: "5107 Thomas Drive"
      fill_in "Shipping city", with: "Richton Park"
      fill_in "Shipping state", with: "IL"
      fill_in "Shipping zip", with: "60471"
      fill_in "Additional Info or Part Inquiry", with: "I needs to replace all. Please send entire product assembly."

      click_on "Submit Message"
      expect(page).to have_text('contact-thankyou-message')
    end

  end

  describe '(rma request)', js: true do

    scenario 'successfully' do
      skip "ng-switch doesn't render the page right for testing"
      fill_in "Name", with: "Joey"
      fill_in "Email", with: "joey@joey.com"
      choose "Product Repair"
      fill_in "Company Name", with: "ACME"
      fill_in "HARMAN Account Number", with: "493475934"
      select @brand.name, from: "Brand of Your Product"
      fill_in "Product Model", with: "CoolThing 5000"
      fill_in "Product Serial Number", with: "3498234"
      choose "No"
      fill_in "Date of Purchase", with: 2.years.ago

      fill_in "Address (No P.O. Boxes)", with: "5107 Thomas Drive"
      fill_in "Shipping city", with: "Richton Park"
      fill_in "Shipping state", with: "IL"
      fill_in "Shipping zip", with: "60471"

      fill_in "Detailed Problem Description", with: "It is broked. "

      click_on "Submit Message"
      expect(page).to have_text('contact-thankyou-message')
    end

  end
end
