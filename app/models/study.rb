class Study < ActiveRecord::Base

  belongs_to :user

  has_many :deployments

end
