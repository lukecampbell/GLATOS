class OtnArray < ActiveRecord::Base

  has_many :deployments

  validates_presence_of :code

end
#
# == Schema Information
#
# Table name: otn_arrays
#
#  id          :integer         not null, primary key
#  code        :string(255)     indexed
#  description :text
#  waterbody   :string(255)
#  region      :string(255)
#

