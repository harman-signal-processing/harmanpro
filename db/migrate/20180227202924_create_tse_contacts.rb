class CreateTseContacts < ActiveRecord::Migration[5.1]
  def change
    create_table :tse_contacts do |t|
      t.string :name
      t.string :job_title
      t.string :phone
      t.string :email

      t.timestamps
    end
  end
end
