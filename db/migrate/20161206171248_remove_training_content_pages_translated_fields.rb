class RemoveTrainingContentPagesTranslatedFields < ActiveRecord::Migration
  def up
    remove_column :training_content_pages, :title
    remove_column :training_content_pages, :subtitle
    remove_column :training_content_pages, :description
    remove_column :training_content_pages, :main_content
    remove_column :training_content_pages, :right_content
    remove_column :training_content_pages, :sub_content    
  end
  
  def down
    add_column :training_content_pages, :title, :string
    add_column :training_content_pages, :subtitle, :string
    add_column :training_content_pages, :description, :string
    add_column :training_content_pages, :main_content, :text
    add_column :training_content_pages, :right_content, :text
    add_column :training_content_pages, :sub_content, :text  
  end
  
end
