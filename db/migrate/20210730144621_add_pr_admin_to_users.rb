class AddPrAdminToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :pr_admin, :boolean, default: false
  end
end
