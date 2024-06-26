class AddTopNavNameToMenuItems < ActiveRecord::Migration[7.1]
  def change
    add_column :menu_items, :top_nav_name, :string
  end
end
