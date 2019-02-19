class CreateContactInfoContactProSiteOptions < ActiveRecord::Migration[5.2]
  def change
    create_table :contact_info_contact_pro_site_options do |t|
      t.boolean :showonweb, null: false, default: false
      t.boolean :showforsolutions, null: false, default: false
      t.boolean :showforchannels, null: false, default: false
      t.references :contact_info_contact, foreign_key: true, index: {name:'idx_contact_prosite_options_on_contact_id'}

      t.timestamps
    end
  end
end
