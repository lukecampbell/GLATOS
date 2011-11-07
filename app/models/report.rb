class Report < ActiveRecord::Base

  belongs_to  :tag_deployment

  validates :input_tag, :description, :method, :name, :email, :length, :weight, :fishtype, :found, :presence => true
  validates :email, :format => { :with => /^([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})$/i, :message => "Invalid Email Address" }

  set_rgeo_factory_for_column(:location, RGeo::Geographic.spherical_factory(:srid => 4326))

  METHODS = ['Commercial Fishing','Recreational Fishing','Not fishing affiliated']

  before_create { |record| record.reported ||= Time.now.utc }

  def DT_RowId
    self.id
  end

end
# == Schema Information
#
# Table name: reports
#
#  id          :integer         not null, primary key
#  tag         :string(255)     not null, indexed
#  description :text
#  method      :string(255)
#  name        :string(255)
#  phone       :string(255)
#  email       :string(255)
#  city        :string(255)
#  state       :string(255)
#  reported    :datetime
#  found       :datetime
#  length      :decimal(6, 2)
#  weight      :decimal(6, 2)
#  fishtype    :string(255)
#  location    :spatial({:srid= indexed
#
