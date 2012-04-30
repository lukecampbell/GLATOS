class AddRewardToTagDeployments < ActiveRecord::Migration
  def change
  	add_column :tag_deployments,  :reward,        :string
  end
end
