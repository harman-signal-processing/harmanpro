class CreateLearningSessionPages < ActiveRecord::Migration[6.1]
  def change
    create_table :learning_session_pages do |t|
      t.text :body
      t.text :custom_css
      t.references :brand, null:false, foreign_key: true, type: :integer

      t.timestamps
    end
  end
end
