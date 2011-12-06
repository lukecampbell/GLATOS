class AddDepthToReport < ActiveRecord::Migration
  def change
    add_column  :reports, :depth, :decimal,  :scale => 2,  :precision => 6
  end
end
