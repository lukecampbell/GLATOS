class ChangeTagInReports < ActiveRecord::Migration
  def change
    rename_column :reports, :tag, :input_tag
  end
end
