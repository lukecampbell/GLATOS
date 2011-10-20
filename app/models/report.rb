class Report < ActiveRecord::Base

  validates :tag, :description, :method, :name, :phone, :email, :city, :state, :presence => true
  validates :email, :format => { :with => /^([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})$/i, :message => "Invalid Email Address" }

end
