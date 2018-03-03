class CreateDistributors < ActiveRecord::Migration[5.1]
  def change
    create_table :distributors do |t|
      t.string :name
      t.string :country
      t.string :channel_manager
      t.string :contact_name
      t.string :contact_phone
      t.string :contact_email
      t.string :time_zone
      t.text :details_public
      t.text :details_private
      t.string :region

      t.timestamps
    end
  end
end
