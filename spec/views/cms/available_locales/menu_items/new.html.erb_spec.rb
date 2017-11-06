require "rails_helper"

RSpec.describe "cms/available_locales/menu_items/new", as: :view do

  before :all do
    @locale = FactoryBot.create(:available_locale)
  end

  before :each do
    assign(:available_locale, @locale)
    assign(:menu_item, MenuItem.new)
    render
  end

  it "renders the form" do
    expect(rendered).to have_css("form#new_menu_item")
  end

end
