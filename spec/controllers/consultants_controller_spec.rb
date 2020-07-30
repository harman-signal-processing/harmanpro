require 'rails_helper'

RSpec.describe ConsultantsController, type: :controller do

  before :all do
    @brand = FactoryBot.create(:brand,
                                show_on_consultant_page: true,
                                contact_info_for_consultants: "FOO",
                                api_url: 'http://localhost/')
    @brand_without_contacts = FactoryBot.create(:brand,
                                                 show_on_consultant_page: true,
                                                 contact_info_for_consultants: '')
    @other_brand = FactoryBot.create(:brand,
                                      show_on_consultant_page: false)
  end

  describe "GET :index" do
    before do
      get :index
    end

    it "renders index template" do
      expect(response).to render_template('index')
    end
  end

  describe "GET :software (json)" do
    before do
      @software = {"name":"Ethernet Device Discoverer","formatted_name":"Ethernet Device Discoverer v2.0 (Windows)","version":"2.0","platform":"Windows","id":"ethernet-device-discoverer-v2-0-windows","direct_download_url":"http://adn.harmanpro.com/softwares/wares/397_1429552081/Ethernet%20Device%20Discoverer%20v2.zip","url":"http://www.crownaudio.com/api/v2/brands/crown/softwares/ethernet-device-discoverer-v2-0-windows"}
      expect(BrandApi).to receive(:software).and_return([@software])

      get :software, params: { format: 'json' }
    end

  end

end
