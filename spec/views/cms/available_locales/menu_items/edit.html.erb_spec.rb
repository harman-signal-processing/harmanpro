require "rails_helper"

RSpec.describe "cms/available_locales/menu_items/edit", as: :view do

  before :all do
    @available_locale = FactoryBot.create(:available_locale)
    @menu_item = FactoryBot.create(:menu_item, locale: @available_locale)
  end

  before :each do
    assign(:available_locale, @available_locale)
    assign(:menu_item, @menu_item)
    render
  end

  it "renders the form" do
    expect(rendered).to have_css 'form.edit_menu_item'
  end
end
