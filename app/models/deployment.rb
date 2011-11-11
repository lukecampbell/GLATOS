class Deployment < ActiveRecord::Base
  require 'rgeo/geo_json'

  belongs_to :study
  belongs_to :otn_array

  set_rgeo_factory_for_column(:location, RGeo::Geographic.spherical_factory(:srid => 4326))

  def DT_RowId
    self.id
  end

  def code
    "#{otn_array.code}-#{station}"
  end

  def geo
    return RGeo::GeoJSON.encode(self.location)
  end

  def geojson
    removals = ["location","id","station","otn_array_id"]
    s = self.attributes.delete_if {|key, value| removals.include?(key) }
    s[:otn_array] = otn_array.code
    s[:code] = code
    return RGeo::GeoJSON::Feature.new(self.location, self.id, s)
  end

  def latitude(round=3)
    location.latitude.round(round)
  end

  def longitude(round=3)
    location.longitude.round(round)
  end

end
# == Schema Information
#
# Table name: deployments
#
#  id           :integer         not null, primary key
#  start        :datetime
#  ending       :datetime
#  study_id     :integer
#  location     :spatial({:srid= indexed
#  otn_array_id :integer
#  station      :integer
#  model        :string(255)
#  seasonal     :boolean
#
