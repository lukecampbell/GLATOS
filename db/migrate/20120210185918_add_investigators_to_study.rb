class AddInvestigatorsToStudy < ActiveRecord::Migration
  def change
    add_column :studies, :investigators, :text
  end
end
