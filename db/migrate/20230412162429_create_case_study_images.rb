class CreateCaseStudyImages < ActiveRecord::Migration[7.0]
  def change
    create_table :case_study_images do |t|
      t.integer :case_study_id
      t.integer :position
      t.string :image_file_name
      t.string :image_content_type
      t.datetime :image_updated_at
      t.integer :image_file_size

      t.timestamps
    end
    add_index :case_study_images, :case_study_id
  end
end
