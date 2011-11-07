class RenameEndColumnOnStudies < ActiveRecord::Migration
  def change
    rename_column :studies, :end, :ending
  end
end
