class CreateBrandMediaCoverages < ActiveRecord::Migration[6.1]
  def change
    create_table :brand_media_coverages do |t|
      t.integer :media_coverage_id
      t.integer :brand_id

      t.timestamps
    end
    add_index :brand_media_coverages, :media_coverage_id
    add_index :brand_media_coverages, :brand_id
  end
end
