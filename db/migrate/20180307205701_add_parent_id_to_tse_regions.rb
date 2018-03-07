class AddParentIdToTseRegions < ActiveRecord::Migration[5.1]
  def change
    add_column :tse_regions, :parent_id, :integer
    add_index :tse_regions, :parent_id

    north_america = TseRegion.where(name: "North America").first_or_create
    TseRegion.where("name like ?", 'NA%').each do |region|
      region.update_column(:parent_id, north_america.id)
      north_america.tse_contacts += region.tse_contacts
    end

    emea = TseRegion.where(name: "EMEA").first_or_create
    TseRegion.where("name like ?", 'EMEA%').each do |region|
      unless region == emea
        region.update_column(:parent_id, emea.id)
        emea.tse_contacts += emea.tse_contacts
      end
    end
  end
end
