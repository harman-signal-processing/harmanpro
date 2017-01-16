class RemoveExtraSlugs < ActiveRecord::Migration[5.0]
  def change
    remove_column :case_studies, :slug
    remove_column :events, :slug
    remove_column :landing_pages, :slug
    remove_column :products, :slug
    remove_column :product_types, :slug
    remove_column :reference_systems, :slug
    remove_column :vertical_markets, :slug
    remove_column :training_content_pages, :slug
    remove_column :venues, :slug
  end
end
