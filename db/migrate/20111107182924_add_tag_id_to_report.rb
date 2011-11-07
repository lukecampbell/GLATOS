class AddTagIdToReport < ActiveRecord::Migration
  def change
    add_column  :reports, :tag_id, :integer
    add_index   :reports, :tag_id
  end
end
