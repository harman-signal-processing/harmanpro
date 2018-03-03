class AddShowOnVerticalMarketPageToCaseStudies < ActiveRecord::Migration[5.1]
  def change
    add_column :case_study_vertical_markets, :show_on_vertical_market_page, :boolean, default: true

    CaseStudyVerticalMarket.update_all(show_on_vertical_market_page: true)
  end
end
