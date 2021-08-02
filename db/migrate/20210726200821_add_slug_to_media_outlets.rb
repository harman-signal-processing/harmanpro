class AddSlugToMediaOutlets < ActiveRecord::Migration[6.1]
  def change
    add_column :media_outlets, :slug, :string
    add_index :media_outlets, :slug
  end
end
