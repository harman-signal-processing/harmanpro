class CreateEmeaEmployeeContacts < ActiveRecord::Migration[5.1]
  def change
    create_table :emea_employee_contacts do |t|
      t.string :department
      t.string :job_function
      t.string :position
      t.string :name
      t.string :email
      t.string :telephone
      t.string :mobile
      t.string :brands
      t.string :country

      t.timestamps
    end
    add_index :emea_employee_contacts, :department
    add_index :emea_employee_contacts, :job_function
  end
end
