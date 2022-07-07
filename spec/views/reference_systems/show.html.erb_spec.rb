require 'rails_helper'

RSpec.describe "reference_systems/show", :type => :view do

  before :all do
    @vertical_market = FactoryBot.create(:vertical_market)
    @reference_systems = FactoryBot.create_list(:reference_system, 3, vertical_market: @vertical_market)
    @reference_system = @reference_systems.second
    @product_type = FactoryBot.create(:product_type)
    @product = FactoryBot.create(:product)
    rspt = FactoryBot.create(
      :reference_system_product_type,
      reference_system: @reference_system,
      product_type: @product_type
    )
    FactoryBot.create(
      :reference_system_product_type_product,
      reference_system_product_type: rspt,
      product: @product
    )

    assign(:reference_system, @reference_system)
    assign(:vertical_market, @vertical_market)
    assign(:lead, Lead.new)
  end

  before :each do
    render
  end

  context "general" do

    it "displays the reference_system name as a title" do
      expect(rendered).to have_css("h1", text: @reference_system.slider_name)
    end

    it "links back to the vertical market" do
      expect(rendered).to have_link(@vertical_market.name.downcase, href: vertical_market_path(@vertical_market))
    end

    it "links to previous and next reference_systems" do
      expect(rendered).to have_link("previous", href: vertical_market_reference_system_path(@vertical_market, @reference_systems.first))
      expect(rendered).to have_link("next", href: vertical_market_reference_system_path(@vertical_market, @reference_system.next))
    end

  end

  context "system-diagram" do

    it "displays reference_system headline and description paragraph" do
      expect(rendered).to have_content(@reference_system.description)
      expect(rendered).to have_css("h2", text: @reference_system.headline)
    end

    it "displays the system diagram" do
      expect(rendered).to match "system_diagrams/original" #@reference_system.system_diagram.url(:original)
    end

  end

  context "retail" do
    it "shows the product types involved" do
      expect(rendered).to have_content(@product_type.name)
    end

    it "has links to the product" do
      expect(rendered).to have_link(@product.name)
    end
  end

end
