class CreateLeadFollowups < ActiveRecord::Migration[6.1]
  def change
    create_table :lead_followups do |t|
      t.string :recipient_id
      t.text :note

      t.timestamps
    end
    add_index :lead_followups, :recipient_id
  end
end
