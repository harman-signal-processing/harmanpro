class AddHtmlToResources < ActiveRecord::Migration[7.1]
  def change
    add_column :resources, :html, :text
  end
end
