class RenameTranslatorForeignKey < ActiveRecord::Migration[5.0]
  def change
    rename_column :locale_translators, :admin_user_id, :user_id
  end
end
