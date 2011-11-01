class AddRequestedRoleToUser < ActiveRecord::Migration
  def change
    add_column :users, :requested_role, :string
  end
end
