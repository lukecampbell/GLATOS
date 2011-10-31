class Report < ActiveRecord::Base

  validates :tag, :description, :method, :name, :phone, :email, :city, :state, :length, :weight, :fishtype, :found, :presence => true
  validates :email, :format => { :with => /^([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})$/i, :message => "Invalid Email Address" }

  set_rgeo_factory_for_column(:location, RGeo::Geographic.spherical_factory(:srid => 4326))

  METHODS = ['Commercial Fishing','Recreational Fishing','Not fishing affiliated']

  before_create { |record| record.reported ||= Time.now.utc }

  def DT_RowId
    self.id
  end

end
