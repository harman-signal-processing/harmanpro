class AddExtraContentToVerticalMarkets < ActiveRecord::Migration
  def change
    reversible do |dir|
      dir.up do
        VerticalMarket.add_translation_fields! extra_content: :text
      end

      dir.down do
        remove_column :vertical_market_translations, :extra_content
      end
    end
  end
end
