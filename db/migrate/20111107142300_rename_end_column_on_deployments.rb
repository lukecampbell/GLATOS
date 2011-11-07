class RenameEndColumnOnDeployments < ActiveRecord::Migration
  def change
    rename_column :deployments, :end, :ending
  end
end
