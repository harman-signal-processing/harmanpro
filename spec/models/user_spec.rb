require "rails_helper"

RSpec.describe User do

  before :all do
    @user = FactoryBot.create(:user, translator: true)
  end

  subject { @user }

  it "can have several locales for which she translates" do
    locale = FactoryBot.create(:available_locale)
    FactoryBot.create(:locale_translator, translator: @user, locale: locale)

    expect(@user.locales_to_translate).to include(locale)
  end

  it ".translatable_locales removes the default" do
    locale = FactoryBot.create(:available_locale, key: I18n.default_locale)
    FactoryBot.create(:locale_translator, translator: @user, locale: locale)

    expect(@user.translatable_locales).not_to include(locale)
  end

  it ".is_employee? returns true if the email address matches harman.com" do
    user = FactoryBot.build(:user, email: "fred.jones@harman.com")

    expect(user.is_employee?).to be(true)
  end

  it ".is_employee? returns false if the email doesn't match harman.com" do
    user = FactoryBot.build(:user, email: "fred.jones@not_harman.com")

    expect(user.is_employee?).to be(false)
  end

end
