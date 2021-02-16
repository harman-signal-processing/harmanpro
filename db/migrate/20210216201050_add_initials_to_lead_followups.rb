class AddInitialsToLeadFollowups < ActiveRecord::Migration[6.1]
  def change
    add_column :lead_followups, :initials, :string
  end
end
