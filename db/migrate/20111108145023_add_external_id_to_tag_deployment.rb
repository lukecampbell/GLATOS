class AddExternalIdToTagDeployment < ActiveRecord::Migration
  def change
    add_column  :tag_deployments,   :external_code,         :string
    add_column  :reports,           :input_external_code,   :string
  end
end
