require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the EmeaHelper. For example:
#
# describe EmeaHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe EmeaHelper, type: :helper do

  describe "top nav generator" do

    before do
      @user = FactoryBot.build(:user)
    end

    it "links to the homepage" do
      FactoryBot.create(:emea_page, title: "Home", position: 1)

      topnav = helper.emea_top_nav_items(@user)

      expect(topnav).to include(link_to("Home", emea_root_path))
    end

    it "generates anchor links" do
      page = FactoryBot.create(
        :emea_page,
        position: 2,
        content: "...<a id=\"foo-bar\"></a>..."
      )

      topnav = helper.emea_top_nav_items(@user)

      expect(topnav).to include(link_to(page.title, emea_page_path(page)))
      expect(topnav).to include(link_to("Foo Bar", emea_page_path(page, anchor: "foo-bar")))
    end
  end

  describe "employee only top nav" do

    it "shows employee-only content to employees" do
      user = FactoryBot.build(:user, email: "fred@harman.com")
      page = FactoryBot.create(:emea_page, title: "For Employees", position: 8, employee_only: true)

      topnav = helper.emea_top_nav_items(user)

      expect(topnav).to include(link_to(page.title, emea_page_path(page)))
    end

    it "does not show employee-only content to non-employees" do
      user = FactoryBot.build(:user, email: "fred@not_harman.com")
      page = FactoryBot.create(:emea_page, title: "For Employees", position: 8, employee_only: true)

      topnav = helper.emea_top_nav_items(user)

      expect(topnav).not_to include(link_to(page.title, emea_page_path(page)))
    end
  end
end
