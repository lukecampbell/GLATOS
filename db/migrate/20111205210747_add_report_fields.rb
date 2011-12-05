class AddReportFields < ActiveRecord::Migration
  def change
    remove_column :reports, :weight
    add_column    :reports, :didwith, :string
    add_column    :reports, :comments, :text
  end
end
