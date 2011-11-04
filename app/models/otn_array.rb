class OtnArray < ActiveRecord::Base

  has_many :deployments

  validates_presence_of :code

end
