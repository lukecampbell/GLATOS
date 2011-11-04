class AddArrayAndStationToDeployment < ActiveRecord::Migration
  def change
    add_column :deployments,  :otn_array_id,  :integer
    add_column :deployments,  :station,       :integer
    add_column :deployments,  :model,         :string
    add_column :deployments,  :seasonal,      :boolean
  end
end
