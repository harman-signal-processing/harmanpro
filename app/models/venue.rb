class Venue < ApplicationRecord
  translates :slug, :name, :description
  extend FriendlyId
  friendly_id :name, use: :globalize

  validates :name, presence: true, uniqueness: true

  def should_generate_new_friendly_id?
    true
  end
end
