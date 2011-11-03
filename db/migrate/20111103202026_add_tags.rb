class AddTags < ActiveRecord::Migration
  def change
    create_table(:tags) do |t|
      t.integer   :study_id
      t.string    :serial
      t.string    :code
      t.string    :code_space
      t.string    :lifespan
      t.datetime  :endoflife
      t.string    :model
      t.string    :manufacturer
      t.string    :type
      t.text      :description
    end
    add_index :tags, :study_id
    add_index :tags, :model
  end
end
