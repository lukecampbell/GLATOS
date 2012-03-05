class ChangeAgeToText < ActiveRecord::Migration
  def change
    change_column :tag_deployments, :age, :string
  end
end
