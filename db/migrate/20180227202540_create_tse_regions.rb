class CreateTseRegions < ActiveRecord::Migration[5.1]
  def change
    create_table :tse_regions do |t|
      t.string :name

      t.timestamps
    end
  end
end
