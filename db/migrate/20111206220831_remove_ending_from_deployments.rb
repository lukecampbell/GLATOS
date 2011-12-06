class RemoveEndingFromDeployments < ActiveRecord::Migration
  def change
      remove_column :deployments, :ending
  end
end
