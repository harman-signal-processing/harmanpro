class CreateAdminLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :admin_logs do |t|
      t.integer :user_id
      t.text :action
      
      t.timestamps
    end
  end
end
