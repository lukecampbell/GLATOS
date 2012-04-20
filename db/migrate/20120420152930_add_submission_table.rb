class AddSubmissionTable < ActiveRecord::Migration
  def change
    create_table(:submissions) do |t|
      t.integer           :user_id
      t.has_attached_file :spreadsheet
      t.string            :status
      t.timestamps
    end
  end
end
