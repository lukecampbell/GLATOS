class Tag < ActiveRecord::Base
  include PgSearch

  pg_search_scope :search_all,
                  :against => [:serial, :code, :code_space, :model, :manufacturer, :description],
                  :using => {
                    :tsearch => {:prefix => true},
                    :trigram => {}
                  }

  has_many      :tag_deployments, :dependent => :destroy

  belongs_to    :study

  validates_uniqueness_of   :code, :code_space, :serial, :case_sensitive => false

  scope :find_match, lambda { |code| where("code ILIKE ? OR code_space ILIKE ?", "%#{code}%","%#{code}%").limit(1) }

  def active_deployment
    tag_deployments.order("release_date DESC").limit(1).first
  end

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
