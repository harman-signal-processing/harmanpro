class AddCustomerRatingToServiceCenters < ActiveRecord::Migration[6.1]
  def change
    add_column :service_centers, :customer_rating, :decimal, precision: 10, scale: 2
  end
end
