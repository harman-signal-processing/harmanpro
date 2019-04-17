class CreateContactInfoContactSupportedBrands < ActiveRecord::Migration[5.2]
  def change
    create_table :contact_info_contact_supported_brands do |t|
      t.references :contact_info_contact, foreign_key: true, index: {name:'idx_contact_info_on_supported_brands_contact_id'} 
      t.references :brand, foreign_key: true, type: :integer,  index: {name:'idx_contact_info_on_supported_brands_brand_id'} 
      t.integer :position, index: true
      t.timestamps
    end
  end
end
