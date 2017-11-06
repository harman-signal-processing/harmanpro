require 'rails_helper'

RSpec.describe ReferenceSystem, :type => :model do
  before :all do
    @vertical_market = FactoryBot.create(:vertical_market)
    @reference_systems = FactoryBot.create_list(:reference_system, 3, vertical_market: @vertical_market)
    @reference_system = @reference_systems.second
  end

  subject { @reference_system }
  it { should respond_to(:retail?) }
  it { should respond_to(:vertical_market) }
  it { should respond_to(:headline) }
  it { should respond_to(:description) }
  it { should respond_to(:venue_size_descriptor) }
  it { should respond_to(:banner) }
  it { should respond_to(:system_diagram) }
  it { should respond_to(:friendly_id) }

  context "as part of a list" do
    it "should have a previous reference_system" do
      expect(@reference_system.previous).to eq(@reference_systems.first)
    end
    it "should have a next reference_system" do
      expect(@reference_system.next).to eq(@reference_systems.last)
    end
  end

  context "with products" do
    it { should respond_to(:reference_system_product_types) }
  end

  describe "deleting" do
    it "should delete related ReferenceSystemProductTypes" do
      reference_system_product_type = FactoryBot.create(:reference_system_product_type)
      reference_system = reference_system_product_type.reference_system
      product_type = reference_system_product_type.product_type

      reference_system.destroy

      expect(ReferenceSystemProductType.exists?(reference_system_product_type.id)).to be false
      expect(ProductType.exists?(product_type.id)).to be true
    end
  end

  describe "friendly id" do
    it "generates a new slug when name changes" do
      old_slug = @reference_system.slug

      @reference_system.name = "Yo Mama #{@reference_system.name}"
      @reference_system.save
      @reference_system.reload

      expect(@reference_system.slug).not_to eq old_slug
      expect(@reference_system.slug.present?).to be(true)
    end
  end

  describe "without_translations(:locale) collection" do
    it "includes missing translations" do
      needs = ReferenceSystem.without_translations(:es)

      expect(needs).to include(@reference_system)
    end

    it "does not include those which are translated" do
      reference_system = FactoryBot.create(:reference_system)

      I18n.locale = :es
      reference_system.name = "Translated Name"
      reference_system.description = "Translated Description"
      reference_system.headline = "Translated Headline"
      reference_system.venue_size_descriptor = "Trans. Descr."
      reference_system.save

      needs = ReferenceSystem.without_translations(:es)

      expect(needs).not_to include(reference_system)
    end
  end

  describe "updated_but_not_translated(:locale) collection" do

    it "includes those where main item was updated, but translation was not" do
      reference_system = FactoryBot.create(:reference_system)

      I18n.locale = :es
      reference_system.name = "Translated Name"
      reference_system.description = "Translated Description"
      reference_system.headline = "Translated Headline"
      reference_system.venue_size_descriptor = "Trans. Descr."
      reference_system.save

      sleep(1) # to allow parent object to become out of sync

      I18n.locale = I18n.default_locale
      reference_system.name = "Updated Name"
      reference_system.description = "Updated Description"
      reference_system.save

      updated = ReferenceSystem.updated_but_not_translated(:es)

      expect(updated).to include(reference_system)
    end

  end

end
