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
    get_array(:organizations)
  end

  def organizations=(orgs)
    set_array(orgs, :organizations)
  end

  def objectives
    get_array(:objectives)
  end

  def objectives=(objs)
    set_array(objs, :objectives)
  end

  def funding
    get_array(:funding)
  end

  def funding=(funds)
    set_array(funds, :funding)
  end

  def investigators
    get_array(:investigators)
  end

  def investigators=(inves)
    set_array(inves, :investigators)
  end

  def get_array(sym)
    read_attribute(sym).split("=;=") rescue []
  end

  def set_array(setme, sym)
    if setme.is_a? String
      write_attribute(sym, setme)
    elsif setme.is_a? Array
      write_attribute(sym, setme.join("=;="))
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

