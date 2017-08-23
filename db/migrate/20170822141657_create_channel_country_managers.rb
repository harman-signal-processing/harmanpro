class CreateChannelCountryManagers < ActiveRecord::Migration[5.0]
  def change
    create_table :channel_country_managers do |t|
      t.integer :channel_manager_id
      t.integer :channel_country_id
      t.integer :channel_id

      t.timestamps
    end
    add_index :channel_country_managers, :channel_manager_id
    add_index :channel_country_managers, :channel_country_id
    add_index :channel_country_managers, :channel_id
  end
end
