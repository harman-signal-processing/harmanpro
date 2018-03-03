class AddWebsiteToDistributors < ActiveRecord::Migration[5.1]
  def change
    add_column :distributors, :website, :string
  end
end
