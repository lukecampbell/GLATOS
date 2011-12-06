class AddFrequencyToDeployment < ActiveRecord::Migration
  def change
    add_column  :deployments,  :frequency,   :integer
  end
end
