class CreateDistributorInfoDistributorPhones < ActiveRecord::Migration[5.2]
  def change
    create_table :distributor_info_distributor_phones do |t|
      t.integer :position, index: true
      t.references :distributor_info_distributor, foreign_key: true, index: {name: 'idx_distributor_phones_on_distributor_id'}
      t.references :contact_info_phone, foreign_key: true, index: {name: 'idx_distributor_phones_on_phone_id'}
      
      t.timestamps
    end
  end
end
