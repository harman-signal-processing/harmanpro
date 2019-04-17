class CreateContactInfoTeamGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :contact_info_team_groups do |t|
      t.string :name

      t.timestamps
    end
    add_index :contact_info_team_groups, :name
  end
end
