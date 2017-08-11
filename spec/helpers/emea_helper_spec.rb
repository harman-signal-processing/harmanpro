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

    it "links to the homepage" do
      FactoryGirl.create(:emea_page, title: "Home", position: 1)

      topnav = helper.emea_top_nav_items

      expect(topnav).to include(link_to("Home", emea_root_path))
    end

    it "generates anchor links" do
      page = FactoryGirl.create(
        :emea_page,
        position: 2,
        content: "...<a id=\"foo-bar\"></a>..."
      )

      topnav = helper.emea_top_nav_items

      expect(topnav).to include(link_to(page.title, emea_page_path(page)))
      expect(topnav).to include(link_to("Foo Bar", emea_page_path(page, anchor: "foo-bar")))
    end
  end
end
