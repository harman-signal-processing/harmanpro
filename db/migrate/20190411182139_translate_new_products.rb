class TranslateNewProducts < ActiveRecord::Migration[5.2]
  def self.up
    NewProduct.create_translation_table!({
      name: :string,
      content: :text,
      more_info: :string,
      press_release: :string
    }, {
      migrate_data: true,
      remove_source_columns: true
    })
  end

  def self.down
    NewProduct.drop_translation_table! migration_data: true
  end
end
