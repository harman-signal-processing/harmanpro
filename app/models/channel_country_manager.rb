class ChannelCountryManager < ApplicationRecord
  belongs_to :channel_manager
  belongs_to :channel_country
  belongs_to :channel

  validates :channel_country, presence: true
  validates :channel, presence: true

  attr_accessor :created_from
end
