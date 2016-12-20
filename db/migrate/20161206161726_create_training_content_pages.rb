class CreateTrainingContentPages < ActiveRecord::Migration
  def change
    create_table :training_content_pages do |t|
      t.string :title
      t.string :subtitle
      t.string :slug
      t.text :main_content
      t.text :right_content
      t.text :sub_content

      t.timestamps null: false
    end
    add_index :training_content_pages, :slug
  end
end
