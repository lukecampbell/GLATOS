class TagDeployment < ActiveRecord::Base

  belongs_to :tag

  has_one    :report

  validates :tag_id, :release_date, :presence => true

  validates_inclusion_of :common_name, :in => Fish::TYPES
  #validates_inclusion_of :scientific_name, :in => Fish::SCITYPES
  #validates_inclusion_of :wild_or_hatchery, :in => Fish::WOH
  #validates_inclusion_of :sex, :in => Fish::SEX

  set_rgeo_factory_for_column(:capture_geo, RGeo::Geographic.spherical_factory(:srid => 4326))
  set_rgeo_factory_for_column(:surgery_geo, RGeo::Geographic.spherical_factory(:srid => 4326))
  set_rgeo_factory_for_column(:release_geo, RGeo::Geographic.spherical_factory(:srid => 4326))

end
# == Schema Information
#
# Table name: tag_deployments
#
#  id                                        :integer         not null, primary key
#  tag_id                                    :integer         indexed
#  tagger                                    :string(255)
#  common_name                               :string(255)
#  scientific_name                           :string(255)
#  capture_location                          :string(255)
#  capture_geo                               :spatial({:srid= indexed
#  capture_date                              :datetime
#  capture_depth                             :decimal(6, 2)
#  wild_or_hatchery                          :string(255)
#  stock                                     :string(255)
#  length                                    :decimal(6, 2)
#  weight                                    :decimal(6, 2)
#  age                                       :decimal(5, 2)
#  sex                                       :string(255)
#  dna_sample_taken                          :boolean
#  treatment_type                            :string(255)
#  temperature_change                        :decimal(4, 2)
#  holding_temperature                       :decimal(4, 2)
#  surgery_location                          :string(255)
#  surgery_geo                               :spatial({:srid= indexed
#  surgery_date                              :datetime
#  sedative                                  :string(255)
#  sedative_concentration                    :string(255)
#  anaesthetic                               :string(255)
#  buffer                                    :string(255)
#  anaesthetic_concentration                 :string(255)
#  buffer_concentration_in_anaesthetic       :string(255)
#  anesthetic_concentration_in_recirculation :string(255)
#  buffer_concentration_in_recirculation     :string(255)
#  do                                        :integer
#  description                               :text
#  release_group                             :string(255)
#  release_location                          :string(255)
#  release_geo                               :spatial({:srid= indexed
#  release_date                              :datetime
#
