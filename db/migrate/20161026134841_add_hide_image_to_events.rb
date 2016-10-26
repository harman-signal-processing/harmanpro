class AddHideImageToEvents < ActiveRecord::Migration
  def change
    add_column :events, :hide_image, :boolean
  end
end
