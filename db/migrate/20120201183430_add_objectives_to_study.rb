class AddObjectivesToStudy < ActiveRecord::Migration
  def change
    add_column  :studies, :objectives,   :text
  end
end
