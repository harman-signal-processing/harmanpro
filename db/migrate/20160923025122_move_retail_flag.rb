class MoveRetailFlag < ActiveRecord::Migration
  def up
    add_column :vertical_markets, :retail, :boolean, default: false

    ReferenceSystem.where(retail: true).each do |rs|
      rs.vertical_market.update_column(:retail, true)
    end

    remove_column :reference_systems, :retail
  end

  def down
    add_column :reference_systems, :retail, :boolean, default: false

    VerticalMarket.where(retail: true).each do |v|
      v.reference_systems.each {|rs| rs.update_column(:retail, true)}
    end

    remove_column :vertical_markets, :retail
  end
end
