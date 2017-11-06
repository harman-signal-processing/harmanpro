require 'rails_helper'

RSpec.describe Brand, :type => :model do
  before :each do
    @brand = FactoryBot.build(:brand)
  end

  subject { @brand }
  it { should respond_to(:name) }
  it { should respond_to(:url) }
  it { should respond_to(:logo) }
  it { should respond_to(:white_logo) }
  it { should respond_to(:by_harman_logo) }
  it { should respond_to(:logo_collection) }
  it { should respond_to(:friendly_id) }
  it { should respond_to(:downloads_page_url) }
  it { should respond_to(:support_url) }
  it { should respond_to(:marketing_url) }
  it { should respond_to(:training_url) }
  it { should respond_to(:show_on_consultant_page) }
  it { should respond_to(:contact_info_for_consultants) }
  it { should respond_to(:api_url) }
  it { should respond_to(:news_articles) } # Eventually I want to feed the brand sites with this.

  describe "deleting" do
    it "raises an error when related products exist" do
      product = FactoryBot.create(:product)
      brand = product.brand

      brand.destroy

      expect(Brand.exists?(brand.id)).to be true
    end
  end

  it "#all_for_site loads all brands in alphabetical order except service-only brands" do
    brand1 = FactoryBot.create(:brand, name: "ZZZZ")
    brand2 = FactoryBot.create(:brand, name: "AAAAA")
    brand3 = FactoryBot.create(:brand, show_on_main_site: false)

    all = Brand.all_for_site

    expect(all.first).to eq(brand2)
    expect(all.last).to eq(brand1)
    expect(all).not_to include(brand3)
  end

  it "#for_consultant_portal loads brands which are flagged with show_on_consultant_page" do
    Brand.delete_all
    brand1 = FactoryBot.create(:brand, name: "ZZZZ", show_on_consultant_page: false)
    brand2 = FactoryBot.create(:brand, name: "AAAAA", show_on_consultant_page: true)
    brand3 = FactoryBot.create(:brand, show_on_main_site: false, show_on_consultant_page: true)

    brands = Brand.for_consultant_portal

    expect(brands).to include(brand2)
    expect(brands).not_to include(brand1)
    expect(brands).to include(brand3)
  end

  it "#for_consultant_portal_with_contacts loads only brands with contact info and flagged for consultant page" do
    Brand.delete_all
    brand1 = FactoryBot.create(:brand, name: "ZZZZ", show_on_consultant_page: false)
    brand2 = FactoryBot.create(:brand, name: "AAAAA", show_on_consultant_page: true, contact_info_for_consultants: "FOO")
    brand3 = FactoryBot.create(:brand, show_on_main_site: false, show_on_consultant_page: true, contact_info_for_consultants: '')

    brands = Brand.for_consultant_portal_with_contacts

    expect(brands).to include(brand2)
    expect(brands).not_to include(brand1)
    expect(brands).not_to include(brand3)
  end

  it "#for_service_site loads only brands relevant for service site" do
    Brand.delete_all
    brand1 = FactoryBot.create(:brand, name: "ZZZZ")
    brand2 = FactoryBot.create(:brand, name: "AAAAA")
    brand3 = FactoryBot.create(:brand, show_on_services_site: false)

    brands = Brand.for_service_site

    expect(brands.first).to eq(brand2)
    expect(brands.last).to eq(brand1)
    expect(brands).not_to include(brand3)
  end

  it "should require the name" do
    @brand.name = nil

    expect(@brand.valid?).to be false
  end

  it "#first_name should return just the first word in the name" do
    @brand.name = "One Two Three"

    expect(@brand.first_name).to eq "One"
  end

  it "should not allow invalid URLs" do
    @brand.url = "a non-valid url"

    expect(@brand.valid?).to be(false)
  end

  it ".friendly_url formats the url without protocol" do
    @brand.url = "http://somesite.com"
    @brand.save

    expect(@brand.friendly_url).to eq("somesite.com")
  end

  it "should not allow invalid support_url" do
    @brand.support_url = "not a url"

    expect(@brand.valid?).to be(false)
  end

  it "should not allow invalid downloads_page_url" do
    @brand.downloads_page_url = "not a url"

    expect(@brand.valid?).to be(false)
  end

  it "should not allow invalid training_url" do
    @brand.training_url = "not a url"

    expect(@brand.valid?).to be(false)
  end

  it "should allow a blank tech_url" do
    @brand.tech_url = nil

    expect(@brand.valid?).to be true
  end

  it "should not allow an invalid tech_url" do
    @brand.tech_url = "something invalid"

    expect(@brand.valid?).to be false
  end

  describe "friendly id" do
    it "generates a new slug when name changes" do
      @brand.save
      old_slug = @brand.slug

      @brand.name = "Yo Mama #{@brand.name}"
      @brand.save!
      @brand.reload

      expect(@brand.slug).not_to eq old_slug
      expect(@brand.slug.present?).to be(true)
    end
  end

  describe "api urls" do
    it { should respond_to(:products_api) }
    it { should respond_to(:product_api) }
    it { should respond_to(:softwares_api) }
    it { should respond_to(:info_api) }

    it "#api_root uses the provided #api_url" do
      @brand.api_url = "something special"

      expect(@brand.send(:api_root)).to eq @brand.api_url
    end

    it "#api_root generates its own root when #api_url is blank" do
      @brand.api_url = nil

      expect(@brand.send(:api_root)).to match(/#{@brand.friendly_id}/)
    end
  end

end
