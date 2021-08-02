class CountryLeadRecipient < ApplicationRecord
  belongs_to :user
  validates :user, presence: true

  def name
    country
  end
end
