class AddSlugToContactInfoTeamGroup < ActiveRecord::Migration[5.2]
  def change
    add_column :contact_info_team_groups, :slug, :string, after: :id
    add_index :contact_info_team_groups, :slug, unique: true      
  end
end
