class CreateLearningSessionEventSessions < ActiveRecord::Migration[6.1]
  def change
    create_table :learning_session_event_sessions do |t|
      t.string :title
      t.date :session_date
      t.string :session_times
      t.string :register_link
      t.references :learning_session_event, null:false, foreign_key: true, index: {name:'idx_ls_session_on_event_id'}

      t.timestamps
    end
  end
end
