class CaseStudyVerticalMarket < ActiveRecord::Base
  belongs_to :vertical_market
  belongs_to :case_study

  validates :vertical_market, presence: true
  validates :case_study, presence: true

  def self.featured
    active_vertical_markets = VerticalMarket.active.pluck(:id)
    where(vertical_market_id: active_vertical_markets).
      order("RAND()").limit(10)
  end
end
