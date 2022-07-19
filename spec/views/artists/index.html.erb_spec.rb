require 'rails_helper'

RSpec.describe "artists/index", type: :view do

  before :all do
    @artist = FactoryBot.build_stubbed(:artist)
  end

  before do
    assign(:artists, [@artist])
    render
  end

  it "links to artists" do
    expect(rendered).to have_content(@artist.overview)
    expect(rendered).to have_link(@artist.name, href: artist_path(@artist))
  end
end
