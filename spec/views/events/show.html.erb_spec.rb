require "rails_helper"

RSpec.describe "events/show.html.erb", as: :view do

  before :all do
    @current_event = FactoryBot.create(:event,
                                        start_on: 2.days.ago,
                                        end_on: 2.days.from_now,
                                        description: "Coolest show",
                                        featured: true,
                                        page_content: "Yo mama was here.",
                                        image: File.new(Rails.root.join('spec','fixtures','test.jpg')),
                                        active: true)
  end

  before do
    assign(:event, @current_event)
    render
  end

  it "has event content" do
    expect(rendered).to have_content @current_event.name
  end

  it "does not show general description if page content is provided" do
    expect(rendered).not_to have_content @current_event.description
  end

  it "has featured event content" do
    expect(rendered).to match @current_event.image.url(:large)
  end

  it "has page content" do
    expect(rendered).to have_content(@current_event.page_content)
  end
end
