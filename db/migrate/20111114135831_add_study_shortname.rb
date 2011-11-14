class AddStudyShortname < ActiveRecord::Migration
  def change
    add_column :studies, :code, :string, :limit => 20, :null => false
  end
end
