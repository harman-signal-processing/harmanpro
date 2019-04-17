class AddSlugToDistributorInfoDistributor < ActiveRecord::Migration[5.2]
  def change
    add_column :distributor_info_distributors, :slug, :string, after: :id
    add_index :distributor_info_distributors, :slug, unique: true     
  end
end
