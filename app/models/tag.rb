class Tag < ActiveRecord::Base
  has_many :tag_deployments, :dependent => :destroy


end
