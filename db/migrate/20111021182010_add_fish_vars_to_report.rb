class AddFishVarsToReport < ActiveRecord::Migration
  def change
    add_column :reports, :length,     :decimal, :precision => 6, :scale => 2
    add_column :reports, :weight,     :decimal, :precision => 6, :scale => 2
    add_column :reports, :fishtype,   :string
  end
end
