class CreateStudyModel < ActiveRecord::Migration
  def change
    create_table(:studies) do |t|
      t.string   :name,          :null => false
      t.text     :description
      t.datetime :start
      t.datetime :end
      t.string   :url
      t.string   :species
      t.integer  :user_id
    end
  end
end
