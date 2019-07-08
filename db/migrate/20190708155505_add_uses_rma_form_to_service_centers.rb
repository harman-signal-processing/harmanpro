class AddUsesRmaFormToServiceCenters < ActiveRecord::Migration[5.2]
  def change
    add_column :service_centers, :uses_rma_form, :boolean, default: false
  end
end
