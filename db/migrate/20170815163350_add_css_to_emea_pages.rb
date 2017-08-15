class AddCssToEmeaPages < ActiveRecord::Migration[5.0]
  def change
    add_column :emea_pages, :custom_header_code, :text
  end
end
