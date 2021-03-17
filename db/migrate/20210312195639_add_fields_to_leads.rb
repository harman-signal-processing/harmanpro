class AddFieldsToLeads < ActiveRecord::Migration[6.1]
  def change
    add_column :leads, :city, :string
    add_column :leads, :state, :string
    add_column :leads, :country, :string
    add_column :leads, :recipient_id, :string
    add_column :leads, :subscribe, :boolean
  end
end
