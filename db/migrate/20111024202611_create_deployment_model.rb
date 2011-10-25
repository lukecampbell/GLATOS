class CreateDeploymentModel < ActiveRecord::Migration
  def change
    create_table(:deployments) do |t|
      t.datetime  :start
      t.datetime  :end
      t.integer   :study_id
      t.point     :location, :geographic => true, :srid => 4326
    end
    add_index :deployments, :location, :spatial => true
  end
end
