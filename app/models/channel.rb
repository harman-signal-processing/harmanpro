class Channel < ApplicationRecord
  has_many :channel_country_managers, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
