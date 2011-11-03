class Study < ActiveRecord::Base

  belongs_to :user

  has_many :deployments

end
# == Schema Information
#
# Table name: studies
#
#  id          :integer         not null, primary key
#  name        :string(255)     not null
#  description :text
#  start       :datetime
#  end         :datetime
#  url         :string(255)
#  species     :string(255)
#  user_id     :integer
#

