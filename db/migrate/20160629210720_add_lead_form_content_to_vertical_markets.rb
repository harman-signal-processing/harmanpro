class AddLeadFormContentToVerticalMarkets < ActiveRecord::Migration
  def up
    VerticalMarket.add_translation_fields! lead_form_content: :text
  end

  def down
    remove_column :vertical_market_translations, :lead_form_content
  end
end
