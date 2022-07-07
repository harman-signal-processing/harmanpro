class CountryLeadRecipient < ApplicationRecord
  belongs_to :user

  def name
    country
  end
end
