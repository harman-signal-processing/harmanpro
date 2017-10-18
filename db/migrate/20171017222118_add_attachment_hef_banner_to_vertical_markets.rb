class AddAttachmentHefBannerToVerticalMarkets < ActiveRecord::Migration[5.0]
  def change
    change_table :vertical_markets do |t|
      t.attachment :hef_banner
    end
  end
end
