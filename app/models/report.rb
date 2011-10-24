class Report < ActiveRecord::Base

  validates :tag, :description, :method, :name, :phone, :email, :city, :state, :reported, :length, :weight, :fishtype, :found, :presence => true
  validates :email, :format => { :with => /^([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})$/i, :message => "Invalid Email Address" }

  def DT_RowId
    self.id
  end

end
