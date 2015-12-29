require "rails_helper"

RSpec.describe "cms/available_locales/product_types/_form.html.erb" do

  before :all do
    @locale = FactoryGirl.create(:available_locale)
    @product_type = FactoryGirl.create(:product_type)
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
