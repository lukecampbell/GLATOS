class RenameSpreadsheetToZip < ActiveRecord::Migration
  def change
    rename_column :submissions, :spreadsheet_file_name,   :zipfile_file_name
    rename_column :submissions, :spreadsheet_content_type,:zipfile_content_type
    rename_column :submissions, :spreadsheet_file_size,   :zipfile_file_size
    rename_column :submissions, :spreadsheet_updated_at,  :zipfile_updated_at
  end
end
