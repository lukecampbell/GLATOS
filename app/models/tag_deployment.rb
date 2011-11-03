class TagDeployment < ActiveRecord::Base

  belongs_to :tag

  validates_inclusion_of :common_name, :in => Fish::TYPES
  validates_inclusion_of :scientific_name, :in => Fish::SCITYPES
  validates_inclusion_of :wild_or_hatchery, :in => Fish::WOH
  validates_inclusion_of :sex, :in => Fish::SEX

end
