class CreateEmeaPageResources < ActiveRecord::Migration[5.0]
  def change
    create_table :emea_page_resources do |t|
      t.string :name
      t.string :attachment_file_name
      t.integer :attachment_file_size
      t.string :attachment_content_type
      t.datetime :attachment_updated_at
      t.boolean :featured
      t.integer :position
      t.string :link
      t.boolean :new_window

      t.timestamps
    end
  end
end
