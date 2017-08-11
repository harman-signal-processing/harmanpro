class AddPinchContentToEmeaPages < ActiveRecord::Migration[5.0]
  def change
    add_column :emea_pages, :pinch_content, :boolean, default: true
  end
end
