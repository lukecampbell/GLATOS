class AddContactedAndResolvedToReport < ActiveRecord::Migration
  def change
    add_column  :reports, :contacted, :boolean
    add_column  :reports, :resolved,  :boolean
  end
end
