class CreateTseContactDomains < ActiveRecord::Migration[5.1]
  def change
    create_table :tse_contact_domains do |t|
      t.integer :tse_contact_id
      t.integer :tse_domain_id
      t.integer :rank

      t.timestamps
    end
    add_index :tse_contact_domains, :tse_contact_id
    add_index :tse_contact_domains, :tse_domain_id
  end
end
