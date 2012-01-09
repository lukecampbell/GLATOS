class AddColumnsToStudies < ActiveRecord::Migration
  def change
    add_column  :studies, :title,         :text
    add_column  :studies, :benefits,      :text
    add_column  :studies, :organizations, :text
    add_column  :studies, :funding,       :text
    add_column  :studies, :information,   :text
  end
end
