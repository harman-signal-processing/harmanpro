class CreateCountryLeadRecipients < ActiveRecord::Migration[6.1]
  def change
    create_table :country_lead_recipients do |t|
      t.string :country
      t.integer :user_id

      t.timestamps
    end
  end
end
