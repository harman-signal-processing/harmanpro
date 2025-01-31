class AddReleasedAtToNewProducts < ActiveRecord::Migration[8.0]
  def up
    add_column(:new_products, :released_at, :datetime)
    NewProduct.find_each{|np| np.update_column(:released_at, np.released_on.to_time)}
    remove_column(:new_products, :released_on)
  end
  
  def down
    add_column(:new_products, :released_on, :date)
    NewProduct.find_each{|np| np.update_column(:released_on, np.released_at.to_date)}
    remove_column(:new_products, :released_at)
  end
end
