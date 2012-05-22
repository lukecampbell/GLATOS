class RemoveNameRequirementOnStudy < ActiveRecord::Migration
  def up
    change_column :studies, :name, :string, :null => true
  end

  def down
    change_column :studies, :name, :string, :null => false
  end
end
