class CreateNewProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :new_products do |t|
      t.string :name
      t.text :content
      t.string :image_file_name
      t.string :image_content_type
      t.integer :image_file_size
      t.datetime :image_updated_at
      t.date :released_on

      t.timestamps
    end
  end
end
