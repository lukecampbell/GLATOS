class AddMultipleExternalCodes < ActiveRecord::Migration
  def change
    rename_column :tag_deployments, :external_code, :external_codes
    rename_column :reports, :input_external_code, :input_external_codes
  end
end
