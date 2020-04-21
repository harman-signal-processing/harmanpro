class AddYoutubeIdToCaseStudies < ActiveRecord::Migration[5.2]
  def change
    add_column :case_studies, :youtube_id, :string
  end
end
