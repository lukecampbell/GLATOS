class AddReports < ActiveRecord::Migration
  def change
    create_table(:reports) do |t|
      t.string :tag,          :null => false
      t.text   :description
      t.string :method
      t.string :name
      t.string :phone
      t.string :email
      t.string :city
      t.string :state
    end
    add_index :reports, :tag
  end
end
