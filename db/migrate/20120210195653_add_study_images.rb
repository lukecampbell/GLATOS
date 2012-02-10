class AddStudyImages < ActiveRecord::Migration
  def up
    change_table :studies do |t|
      t.has_attached_file :img_first
      t.has_attached_file :img_second
      t.has_attached_file :img_third
      t.has_attached_file :img_fourth
      t.has_attached_file :img_fifth
    end
  end

  def down
    drop_attached_file :studies, :img_first
    drop_attached_file :studies, :img_second
    drop_attached_file :studies, :img_third
    drop_attached_file :studies, :img_fourth
    drop_attached_file :studies, :img_fifth
  end
end
