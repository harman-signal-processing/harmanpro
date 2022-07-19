class ChannelCountryManager < ApplicationRecord
  belongs_to :channel_manager, optional: true
  belongs_to :channel_country
  belongs_to :channel

  attr_accessor :created_from
end
