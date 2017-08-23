class CreateChannelManagers < ActiveRecord::Migration[5.0]
  def change
    create_table :channel_managers do |t|
      t.string :name
      t.string :email
      t.string :telephone

      t.timestamps
    end
  end
end
