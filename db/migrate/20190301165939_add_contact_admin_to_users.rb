class AddContactAdminToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :contact_admin, :boolean
  end
end
