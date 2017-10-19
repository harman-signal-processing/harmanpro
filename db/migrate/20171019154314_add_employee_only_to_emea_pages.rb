class AddEmployeeOnlyToEmeaPages < ActiveRecord::Migration[5.1]
  def change
    add_column :emea_pages, :employee_only, :boolean, default: false
  end
end
