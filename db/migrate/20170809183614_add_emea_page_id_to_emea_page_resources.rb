class AddEmeaPageIdToEmeaPageResources < ActiveRecord::Migration[5.0]
  def change
    add_column :emea_page_resources, :emea_page_id, :integer
    add_index :emea_page_resources, :emea_page_id
  end
end
