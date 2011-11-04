class AddOtnArray < ActiveRecord::Migration
  def change
    create_table(:otn_arrays) do |t|
      t.string    :code
      t.text      :description
    end
    add_index :otn_arrays, :code
  end
end
