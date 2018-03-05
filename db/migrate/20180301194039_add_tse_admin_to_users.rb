class AddTseAdminToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :tse_admin, :boolean
  end
end
