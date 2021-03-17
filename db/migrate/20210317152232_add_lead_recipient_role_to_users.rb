class AddLeadRecipientRoleToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :lead_recipient, :boolean

    User.where(id: CountryLeadRecipient.pluck(:user_id).uniq ).update_all(lead_recipient: true)
  end
end
