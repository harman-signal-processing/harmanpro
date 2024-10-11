class CaseStudyVerticalMarket < ApplicationRecord
  belongs_to :vertical_market
  belongs_to :case_study

  def self.featured(opts={})
    limit = opts[:limit] || 10
    active_vertical_markets = VerticalMarket.active.pluck(:id)
    where(vertical_market_id: active_vertical_markets).
      group(:case_study_id).
      order("created_at DESC").
      limit(limit)
  end
end
