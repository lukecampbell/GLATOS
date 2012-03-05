class ChangeDoToDecimal < ActiveRecord::Migration
  def up
    change_column :tag_deployments, :do, :decimal, :scale => 1, :precision => 6
  end

  def down
    change_column :tag_deployments, :do, :integer
  end
end
