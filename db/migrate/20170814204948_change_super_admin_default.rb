class ChangeSuperAdminDefault < ActiveRecord::Migration[5.0]
  def up
    change_column_default :users, :super_admin, false
  end

  def down
    change_column_default :users, :super_admin, true
  end
end
