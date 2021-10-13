class CreateLearningSessionFeaturedVideos < ActiveRecord::Migration[6.1]
  def change
    create_table :learning_session_featured_videos do |t|
      t.string :title
      t.string :youtube_id
      t.references :brand, null:false, foreign_key: true, type: :integer
      t.integer :position

      t.timestamps
    end
  end
end
