class AddFieldsToMediaLibraryAccessRequest < ActiveRecord::Migration[5.1]
  def change
    add_column :media_library_access_requests, :company, :string
    add_column :media_library_access_requests, :reason_for_request, :text
    add_column :media_library_access_requests, :what_assets, :text
  end
end
