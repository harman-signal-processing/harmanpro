class CreateLocationInfoLocationPhones < ActiveRecord::Migration[5.2]
  def change
    create_table :location_info_location_phones do |t|
      t.integer :position, index: true
      t.references :location_info_location, foreign_key: true, index: {name:'idx_location_phones_on_location_id'}
      t.references :contact_info_phone, foreign_key: true, index: {name:'idx_location_phones_on_phone_id'}
      
      t.timestamps
    end
  end
end
