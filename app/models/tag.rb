class Tag < ActiveRecord::Base
  has_many :tag_deployments, :dependent => :destroy


end
# == Schema Information
#
# Table name: tags
#
#  id           :integer         not null, primary key
#  study_id     :integer         indexed
#  serial       :string(255)
#  code         :string(255)
#  code_space   :string(255)
#  lifespan     :string(255)
#  endoflife    :datetime
#  model        :string(255)     indexed
#  manufacturer :string(255)
#  type         :string(255)
#  description  :text
#
