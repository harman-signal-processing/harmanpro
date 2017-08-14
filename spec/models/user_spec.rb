require "rails_helper"

RSpec.describe User do

  before :all do
    @user = FactoryGirl.create(:user)
  end

  subject { @user }

  it "can have several locales for which she translates" do
    locale = FactoryGirl.create(:available_locale)
    FactoryGirl.create(:locale_translator, translator: @user, locale: locale)

    expect(@user.locales_to_translate).to include(locale)
  end

  it ".translatable_locales removes the default" do
    locale = FactoryGirl.create(:available_locale, key: I18n.default_locale)
    FactoryGirl.create(:locale_translator, translator: @user, locale: locale)

    expect(@user.translatable_locales).not_to include(locale)
  end
end
