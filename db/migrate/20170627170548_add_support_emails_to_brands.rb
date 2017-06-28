class AddSupportEmailsToBrands < ActiveRecord::Migration[5.0]
  def change
    add_column :brands, :tech_support_email, :string
    add_column :brands, :repair_email, :string
    add_column :brands, :parts_email, :string
  end
end
