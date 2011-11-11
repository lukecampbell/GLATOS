class AddFieldsToUserAndReport < ActiveRecord::Migration
  def change
    add_column :users,  :address,   :string
    add_column :users,  :city,      :string
    add_column :users,  :state,     :string
    add_column :users,  :zipcode,   :string,  :limit => 8
    add_column :users,  :phone,     :string
    add_column :users,  :newsletter,:boolean, :default => false
    add_column :reports,:address,   :string
    add_column :reports,:zipcode,   :string,  :limit => 8
    add_column :reports,:newsletter,:boolean, :default => false
  end
end
