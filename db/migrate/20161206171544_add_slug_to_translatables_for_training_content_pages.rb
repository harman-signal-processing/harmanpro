class AddSlugToTranslatablesForTrainingContentPages < ActiveRecord::Migration
  def up
    TrainingContentPage.add_translation_fields! slug: :string
  end
  
  def down
    remove_column :training_content_page_translations, :slug
  end
  
end
