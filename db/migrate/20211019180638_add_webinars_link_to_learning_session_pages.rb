class AddWebinarsLinkToLearningSessionPages < ActiveRecord::Migration[6.1]
  def change
    add_column :learning_session_pages, :webinars_link, :string
  end
end
