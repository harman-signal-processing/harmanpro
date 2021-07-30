class CreateMediaCoverages < ActiveRecord::Migration[6.1]
  def change
    create_table :media_coverages do |t|
      t.date :news_date
      t.integer :media_outlet_id
      t.text :headline
      t.string :media_type
      t.boolean :syndicated
      t.string :media_length
      t.boolean :case_study
      t.string :initiative
      t.string :region
      t.text :link

      t.timestamps
    end
    add_index :media_coverages, :media_outlet_id
  end
end
