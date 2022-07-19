class CaseStudyVerticalMarket < ApplicationRecord
  belongs_to :vertical_market
  belongs_to :case_study

  def self.featured
    active_vertical_markets = VerticalMarket.active.pluck(:id)
    where(vertical_market_id: active_vertical_markets).
      order("created_at DESC").limit(10)
  end
end
