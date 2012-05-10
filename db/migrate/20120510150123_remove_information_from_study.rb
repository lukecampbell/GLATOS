class RemoveInformationFromStudy < ActiveRecord::Migration
  def change
    remove_column :studies, :information
  end
end
