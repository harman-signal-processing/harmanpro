require 'rails_helper'

RSpec.describe "leads/new.html.erb", :type => :view do
  before do
    assign(:lead, Lead.new)
    render
  end

  it "has contact fields" do
    expect(rendered).to have_field("Name")
    expect(rendered).to have_field("Company")
    expect(rendered).to have_field("Email")
    expect(rendered).to have_field("Phone")
    expect(rendered).to have_field("Country")
    expect(rendered).to have_field("Project Description")
    expect(rendered).to have_button("Submit")
  end
end
