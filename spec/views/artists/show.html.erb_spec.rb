require 'rails_helper'

RSpec.describe "artists/show.html.erb", type: :view do

  before :all do
    @artist = FactoryBot.build_stubbed(:artist)
  end

  before do
    assign(:artist, @artist)
    render
  end

  it "shows artist details" do
    expect(rendered).to have_content(@artist.description)
    expect(rendered).to have_content(@artist.name)
    expect(rendered).to match @artist.photo.url(:large)
  end
end
