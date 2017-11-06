require 'rails_helper'

RSpec.describe Product, :type => :model do
  before :all do
    @product = FactoryBot.create(:product)
  end

  subject { @product }
  it { should respond_to(:name) }
  it { should respond_to(:brand) }
  it { should respond_to(:photo) }
  it { should respond_to(:url) }
  it { should respond_to(:description) }
  it { should respond_to(:ecommerce_id) }
  it { should respond_to(:friendly_id) }

  describe "deleting" do
    it "should delete any ReferenceSystemProductTypeProducts" do
      rsptp = FactoryBot.create(:reference_system_product_type_product)
      reference_system_product_type = rsptp.reference_system_product_type
      product = rsptp.product

      product.destroy

      expect(ReferenceSystemProductTypeProduct.exists?(rsptp.id)).to be false
      expect(ReferenceSystemProductType.exists?(reference_system_product_type.id)).to be true
    end
  end

  describe "ecommerce" do
    it "should generate a 'buy now' URL" do
      @product.update_column(:ecommerce_id, "abc123")

      expect(@product.buy_now_url).to match(/http/i)
      expect(@product.buy_now_url).to match(/#{@product.ecommerce_id}/)
    end

    it "#ecommerce_enabled? should return 'false' when no ecommerce_id is provided" do
      product = FactoryBot.create(:product)
      product.update_column(:ecommerce_id, '')

      expect(product.ecommerce_enabled?).to be(false)
      expect(product.buy_now_url).to eq('')
    end

    it "#ecommerce_enabled? should return 'true' when ecommerce_id is provided" do
      @product.update_column(:ecommerce_id, "xyz999")

      expect(@product.ecommerce_enabled?).to be(true)
    end
  end

  describe "friendly id" do
    it ".brand_name loads the brand name" do
      expect(@product.brand_name).to eq @product.brand.name
    end

    it "generates a new slug when name changes" do
      old_slug = @product.slug

      @product.name = "Yo Mama #{@product.name}"
      @product.save
      @product.reload

      expect(@product.slug).not_to eq old_slug
      expect(@product.slug.present?).to be(true)
    end
  end

end
