class CreateTseContactTechnologies < ActiveRecord::Migration[5.1]
  def change
    create_table :tse_contact_technologies do |t|
      t.integer :tse_contact_id
      t.integer :tse_technology_id
      t.integer :rank

      t.timestamps
    end
    add_index :tse_contact_technologies, :tse_contact_id
    add_index :tse_contact_technologies, :tse_technology_id
  end
end
