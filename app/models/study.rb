class Study < ActiveRecord::Base
  include PgSearch

  pg_search_scope :search_all,
                  :against => [:code, :name, :description, :species, :benefits, :objectives, :organizations, :funding],
                  :using => {
                    :tsearch => {:prefix => true},
                    :trigram => {}
                  },
                  :associated_against => {
                    :user =>  [ :name,
                                :organization,
                                :email
                              ]
                  }

  belongs_to  :user

  has_many    :deployments

  has_many    :tags

  validates   :user, :presence => true

  def organizations
    read_attribute(:organizations).split("=;=") rescue []
  end

  def organizations=(orgs)
    if orgs.is_a? String
      write_attribute(:organizations, orgs)
    elsif orgs.is_a? Array
      write_attribute(:organizations, orgs.join("=;="))
    end
  end

  def objectives
    read_attribute(:objectives).split("=;=") rescue []
  end

  def objectives=(objs)
    if objs.is_a? String
      write_attribute(:objectives, objs)
    elsif objs.is_a? Array
      write_attribute(:objectives, objs.join("=;="))
    end
  end

  def funding
    read_attribute(:funding).split("=;=") rescue []
  end

  def funding=(funds)
    if funds.is_a? String
      write_attribute(:funding, funds)
    elsif funds.is_a? Array
      write_attribute(:funding, funds.join("=;="))
    end
  end

end
#
# == Schema Information
#
# Table name: studies
#
#  id          :integer         not null, primary key
#  name        :string(255)     not null
#  description :text
#  start       :datetime
#  ending      :datetime
#  url         :string(255)
#  species     :string(255)
#  user_id     :integer
#  code        :string(20)      not null
#

