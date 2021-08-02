class AddSlugToMediaCoverages < ActiveRecord::Migration[6.1]
  def change
    add_column :media_coverages, :slug, :string
    add_index :media_coverages, :slug
  end
end
