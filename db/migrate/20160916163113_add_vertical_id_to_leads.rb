class AddVerticalIdToLeads < ActiveRecord::Migration
  def change
    add_column :leads, :vertical_market_id, :integer
  end
end
