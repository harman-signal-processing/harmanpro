require 'rails_helper'

RSpec.describe ProductType, :type => :model do

  before :all do
    @product_type = FactoryBot.build(:product_type)
  end

  subject { @product_type }
  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:friendly_id) }

  describe "deleting" do
    it "should delete related ReferenceSystemProductTypes" do
      reference_system_product_type = FactoryBot.create(:reference_system_product_type)
      reference_system = reference_system_product_type.reference_system
      product_type = reference_system_product_type.product_type

      product_type.destroy

      expect(ReferenceSystemProductType.exists?(reference_system_product_type.id)).to be false
      expect(ReferenceSystem.exists?(reference_system.id)).to be true
    end
  end

  describe "friendly id" do
    it "generates a new slug when name changes" do
      old_slug = @product_type.slug

      @product_type.name = "Yo Mama #{@product_type.name}"
      @product_type.save
      @product_type.reload

      expect(@product_type.slug).not_to eq old_slug
      expect(@product_type.slug.present?).to be(true)
    end
  end

end
