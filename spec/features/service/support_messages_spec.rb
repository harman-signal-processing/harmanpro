feature 'completing support form' do

  before :each do
    @brand = FactoryGirl.create(:brand)
    visit service_path
  end

  scenario 'empty form' do
    click_on "Submit Message"
    expect(current_path).to eq service_path
  end

  describe '(tech support)' do
    before :each do
      fill_in "Name", with: "Joey"
      fill_in "Email", with: "joey@joey.com"
      choose "Technical Support"
    end

    scenario 'successfully' do
      #expect email to go to the right brand/contact
      #expect response to be a thankyou
    end

    scenario 'unsucessfully' do
      click_on "Submit Message"
      expect(current_path).to eq service_path
    end
  end

  describe '(parts request)' do
    before :each do
      fill_in "Name", with: "Joey"
      fill_in "Email", with: "joey@joey.com"
      choose "Product Parts"
    end

    scenario 'successfully' do
    end

    scenario 'unsucessfully'
  end

  describe '(rma request)' do
    before :each do
      fill_in "Name", with: "Joey"
      fill_in "Email", with: "joey@joey.com"
      choose "Product Repair"
    end

    scenario 'successfully' do
    end

    scenario 'unsucessfully'
  end
end
