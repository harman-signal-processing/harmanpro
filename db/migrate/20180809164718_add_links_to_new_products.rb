class AddLinksToNewProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :new_products, :more_info, :string
    add_column :new_products, :press_release, :string
  end
end
