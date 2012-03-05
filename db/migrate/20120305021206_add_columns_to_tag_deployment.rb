class AddColumnsToTagDeployment < ActiveRecord::Migration
  def change
    add_column :tag_deployments, :length_type,      :string
    add_column :tag_deployments, :implant_type,     :string
  end
end
