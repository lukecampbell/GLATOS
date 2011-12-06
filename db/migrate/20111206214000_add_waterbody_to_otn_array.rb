class AddWaterbodyToOtnArray < ActiveRecord::Migration
  def change
    add_column  :otn_arrays,  :waterbody, :string
  end
end
