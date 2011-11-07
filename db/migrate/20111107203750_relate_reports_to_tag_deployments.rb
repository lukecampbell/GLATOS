class RelateReportsToTagDeployments < ActiveRecord::Migration
  def change
    rename_column :reports, :tag_id, :tag_deployment_id
    add_index     :reports, :tag_deployment_id
  end
end
