class AddLocationToReports < ActiveRecord::Migration
  def change
    add_column :reports, :location, :point, :geographic => true, :srid => 4326
    add_index  :reports, :location, :spatial => true
  end
end
