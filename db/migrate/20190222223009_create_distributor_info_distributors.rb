class CreateDistributorInfoDistributors < ActiveRecord::Migration[5.2]
  def change
    create_table :distributor_info_distributors do |t|
      t.string :name
      t.string :account_number

      t.timestamps
    end
    add_index :distributor_info_distributors, :name
    add_index :distributor_info_distributors, :account_number
  end
end
