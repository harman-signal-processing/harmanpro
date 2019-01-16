class AddGeoTargetToSlides < ActiveRecord::Migration[5.2]
  def change
    add_column :slides, :geo_target_country, :string
  end
end
