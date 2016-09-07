class CreateSlides < ActiveRecord::Migration
  def change
    create_table :slides do |t|
      t.string :name
      t.integer :locale_id
      t.integer :position
      t.string :background_file_name
      t.integer :background_file_size
      t.string :background_content_type
      t.datetime :background_updated_at
      t.string :bubble_file_name
      t.integer :bubble_file_size
      t.string :bubble_content_type
      t.datetime :bubble_updated_at
      t.string :headline
      t.string :description
      t.string :link_text
      t.string :link_url
      t.boolean :link_new_window, default: false
      t.datetime :start_on
      t.datetime :end_on

      t.timestamps null: false
    end
  end
end
