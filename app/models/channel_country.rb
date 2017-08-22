class ChannelCountry < ApplicationRecord
  has_many :channel_country_managers, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
