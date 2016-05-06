require 'rails_helper'

RSpec.describe MenuItem, type: :model do

  before :all do
    @menu_item = FactoryGirl.create(:menu_item)
  end

  subject { @menu_item }
  it { should respond_to :locale }

  it "locale is a locale" do
    expect(@menu_item.locale).to be_an AvailableLocale
  end

  # This is so that caches are refreshed when menu items change
  it "updating should touch the related locale" do
    updated_at = @menu_item.locale.updated_at

    @menu_item.update_attributes(title: "Foooooo")

    expect(@menu_item.locale.updated_at).to be > updated_at
  end
end
