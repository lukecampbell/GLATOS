class AddRetrievalTable < ActiveRecord::Migration
  def change
    create_table(:retrievals) do |t|
      t.integer   :deployment_id
      t.boolean  :data_downloaded
      t.boolean  :ar_confirm
      t.datetime :recovered
      t.point    :location,         :geographic => true, :srid => 4326
    end
    add_index :retrievals, :location, :spatial => true
    add_index :retrievals, :deployment_id
  end
end