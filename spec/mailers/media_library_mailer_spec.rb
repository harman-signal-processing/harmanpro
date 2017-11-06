require "rails_helper"

RSpec.describe MediaLibraryMailer, type: :mailer do
  before :all do
    FactoryBot.create(:site_setting, name: "media-library-recipients", content: "foo@foo.com, bar@bar.com")
    FactoryBot.create(:site_setting, name: "media-library-sender", content: "ml@domain.com")
    @media_library_access_request = FactoryBot.create(:media_library_access_request)
  end

  describe "access_request" do
    let(:mail) { MediaLibraryMailer.access_request(@media_library_access_request) }

    it "renders the headers" do
      expect(mail.subject).to eq("DAM access request")
      expect(mail.to).to include("foo@foo.com")
      expect(mail.from).to eq(["ml@domain.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match(@media_library_access_request.first_name)
      expect(mail.body.encoded).to match(@media_library_access_request.last_name)
      expect(mail.body.encoded).to match(@media_library_access_request.email)
    end
  end

end
