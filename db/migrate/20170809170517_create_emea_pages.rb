class CreateEmeaPages < ActiveRecord::Migration[5.0]
  def change
    create_table :emea_pages do |t|
      t.string :title
      t.string :slug
      t.string :highlight_color
      t.date :publish_on
      t.text :content
      t.integer :position

      t.timestamps
    end
    add_index :emea_pages, :slug
  end
end
