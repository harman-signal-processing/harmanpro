class CreateDistributorInfoDistributors < ActiveRecord::Migration[5.2]
  def change
    create_table :distributor_info_distributors do |t|
      t.string :name
      t.string :account_number

      t.timestamps
    end
  end
end
