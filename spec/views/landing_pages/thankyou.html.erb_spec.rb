require 'rails_helper'

describe "landing_pages/thankyou.html.erb" do
  before do
    @title = FactoryBot.create(:site_setting, name: "thanks", content: "Thanks!")
    @msg = FactoryBot.create(:site_setting, name: "contact-thankyou-message", content: "You look nice today.")

    render
  end

  it "shows the title and message" do
    expect(rendered).to have_css('h1', text: @title.content)
    expect(rendered).to have_content(@msg.content)
  end
end
