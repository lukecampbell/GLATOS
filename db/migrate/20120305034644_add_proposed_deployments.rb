class AddProposedDeployments < ActiveRecord::Migration
  def change
    add_column :deployments,  :proposed,        :boolean
    add_column :deployments,  :funded,          :boolean
    add_column :deployments,  :proposed_ending, :datetime
  end
end
