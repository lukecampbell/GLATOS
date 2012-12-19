class AddActiveDeploymentCache < ActiveRecord::Migration
  def up
  	add_column :tags, :active_deployment_id, :integer
  end

  def down
  	remove_column :tags, :active_deployment_id
  end
end
