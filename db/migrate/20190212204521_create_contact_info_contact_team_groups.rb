class CreateContactInfoContactTeamGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :contact_info_contact_team_groups do |t|
      t.integer :position
      t.references :contact_info_contact, foreign_key: true, index: {name:'idx_contact_team_groups_on_contact_id'}
      t.references :contact_info_team_group, foreign_key: true, index: {name:'idx_contact_team_groups_on_team_group_id'}

      t.timestamps
    end
  end
end
