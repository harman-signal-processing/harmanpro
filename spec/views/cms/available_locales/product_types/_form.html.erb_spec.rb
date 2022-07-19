require "rails_helper"

RSpec.describe "cms/available_locales/product_types/_form" do

  before :all do
    @locale = FactoryBot.create(:available_locale)
    @product_type = FactoryBot.create(:product_type)
  end

  before :each do
    assign(:available_locale, @locale)
    assign(:product_type, @product_type)
    render
  end

  it "has the fields" do
    expect(rendered).to have_field 'Name'
    expect(rendered).to have_field 'Description'
    expect(rendered).to have_button "Save Changes"
  end

end
