class ChannelManager < ApplicationRecord
  has_many :channel_country_managers, dependent: :nullify

  validates :name, presence: true
end
