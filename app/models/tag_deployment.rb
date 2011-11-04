class TagDeployment < ActiveRecord::Base

  belongs_to :tag

  validates_presence_of :tag_id

  validates_inclusion_of :common_name, :in => Fish::TYPES
  #validates_inclusion_of :scientific_name, :in => Fish::SCITYPES
  #validates_inclusion_of :wild_or_hatchery, :in => Fish::WOH
  #validates_inclusion_of :sex, :in => Fish::SEX

  set_rgeo_factory_for_column(:capture_geo, RGeo::Geographic.spherical_factory(:srid => 4326))
  set_rgeo_factory_for_column(:surgery_geo, RGeo::Geographic.spherical_factory(:srid => 4326))
  set_rgeo_factory_for_column(:release_geo, RGeo::Geographic.spherical_factory(:srid => 4326))

end
