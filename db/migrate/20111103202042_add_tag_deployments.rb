class AddTagDeployments < ActiveRecord::Migration
  def change
    create_table(:tag_deployments) do |t|
      t.integer   :tag_id
      t.string    :tagger
      t.string    :common_name
      t.string    :scientific_name

      t.string    :capture_location
      t.point     :capture_geo,         :geographic => true, :srid => 4326
      t.datetime  :capture_date
      t.decimal   :capture_depth,       :precision => 6, :scale => 2

      t.string    :wild_or_hatchery
      t.string    :stock
      t.decimal   :length,              :precision => 6, :scale => 2
      t.decimal   :weight,              :precision => 6, :scale => 2
      t.decimal   :age,                 :precision => 5, :scale => 2
      t.string    :sex

      t.boolean   :dna_sample_taken
      t.string    :treatment_type
      t.decimal   :temperature_change,  :precision => 4, :scale => 2
      t.decimal   :holding_temperature, :precision => 4, :scale => 2

      t.string    :surgery_location
      t.point     :surgery_geo,         :geographic => true, :srid => 4326
      t.datetime  :surgery_date

      t.string    :sedative
      t.string    :sedative_concentration
      t.string    :anaesthetic
      t.string    :buffer
      t.string    :anaesthetic_concentration
      t.string    :buffer_concentration_in_anaesthetic
      t.string    :anesthetic_concentration_in_recirculation
      t.string    :buffer_concentration_in_recirculation
      t.integer   :do

      t.text      :description

      t.string    :release_group
      t.string    :release_location
      t.point     :release_geo,         :geographic => true, :srid => 4326
      t.datetime  :release_date
    end
    add_index :tag_deployments, :capture_geo, :spatial => true
    add_index :tag_deployments, :surgery_geo, :spatial => true
    add_index :tag_deployments, :release_geo, :spatial => true
    add_index :tag_deployments, :tag_id
  end
end
