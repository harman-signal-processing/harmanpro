require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the EventsHelper. For example:
#
# describe EventsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe EventsHelper, type: :helper do

  describe "event date formatter" do
    it "omits the end date if it is the same as start date" do
      event = FactoryBot.create(:event, start_on: 2.days.from_now, end_on: 2.days.from_now)

      formatted = helper.event_date(event)
      expect(formatted).not_to include(" - ") # the separator
      expect(formatted).to eq(I18n.l(event.start_on, format: :long))
    end

    it "includes the end date if it is different from start date" do
      event = FactoryBot.create(:event, start_on: 2.days.from_now, end_on: 4.days.from_now)

      formatted = helper.event_date(event)
      expect(formatted).to include(" - ") # the separator
      expect(formatted).to include(I18n.l(event.end_on, format: :long))
    end
  end
end
