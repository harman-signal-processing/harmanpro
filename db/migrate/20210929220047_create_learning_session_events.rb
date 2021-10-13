class CreateLearningSessionEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :learning_session_events do |t|
      t.string :title
      t.string :subtitle
      t.text :description

      t.timestamps
    end
  end
end
