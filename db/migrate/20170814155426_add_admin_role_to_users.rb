class AddAdminRoleToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :admin, :boolean, default: false
    User.where("created_at < ?", "2017-08-15".to_date).each{|u| u.update_attributes(admin: true)}
  end
end
