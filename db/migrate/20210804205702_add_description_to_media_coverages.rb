class AddDescriptionToMediaCoverages < ActiveRecord::Migration[6.1]
  def change
    add_column :media_coverages, :description, :text
  end
end
