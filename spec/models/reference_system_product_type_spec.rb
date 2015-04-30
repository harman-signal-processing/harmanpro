require 'rails_helper'

RSpec.describe ReferenceSystemProductType, :type => :model do

  before :all do
    @reference_system_product_type = FactoryGirl.create(:reference_system_product_type)
  end

  subject { @reference_system_product_type }
  it { should respond_to(:reference_system) }
  it { should respond_to(:product_type) }
  it { should respond_to(:quantity) }

  context "products" do
    it { should respond_to(:reference_system_product_type_products) }
    it { should respond_to(:products) }
  end

  describe "icon coordinates" do
    it { should respond_to(:top) }
    it { should respond_to(:left) }
  end

  describe "name" do
    it "concatenates the and reference system and product type names" do
      n = @reference_system_product_type.name

      expect(n).to match(@reference_system_product_type.reference_system.name)
      expect(n).to match(@reference_system_product_type.product_type.name)
    end
  end
end
