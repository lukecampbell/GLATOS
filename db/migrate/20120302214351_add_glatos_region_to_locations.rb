class AddGlatosRegionToLocations < ActiveRecord::Migration
  def change
    add_column :otn_arrays, :region, :string
  end
end
