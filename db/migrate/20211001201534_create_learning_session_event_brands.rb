class CreateLearningSessionEventBrands < ActiveRecord::Migration[6.1]
  def change
    create_table :learning_session_event_brands do |t|
      t.references :learning_session_event, null:false, foreign_key: true
      t.references :brand, null:false, foreign_key: true, type: :integer
      t.index [:learning_session_event_id, :brand_id], unique: true, name: 'by_learning_session_event_brand'

      t.timestamps
    end
  end
end
