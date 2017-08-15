require 'rails_helper'

RSpec.describe LocaleTranslator, type: :model do

  before :all do
    user = FactoryGirl.create(:user, translator: true)
    @lt = FactoryGirl.create(:locale_translator, translator: user)
  end

  subject { @lt }
  it { should respond_to :translator}
  it { should respond_to :locale }

  it "translator is an User" do
    expect(@lt.translator).to be_an(User)
  end

  it "locale is an AvailableLocale" do
    expect(@lt.locale).to be_an(AvailableLocale)
  end
end
