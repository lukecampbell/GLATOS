class AddDeploymentColumns < ActiveRecord::Migration
  def change
    add_column :deployments, :riser_length,     :integer
    add_column :deployments, :bottom_depth,     :integer
    add_column :deployments, :instrument_depth, :integer
    add_column :deployments, :instrument_serial,:string
    add_column :deployments, :rcv_modem_address,:integer
    add_column :deployments, :deployed_by,      :string
    add_column :deployments, :vps,              :boolean
    add_column :deployments, :consecutive,      :integer
  end
end
