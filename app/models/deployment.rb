class Deployment < ActiveRecord::Base
  require 'rgeo/geo_json'

  belongs_to :study

  set_rgeo_factory_for_column(:location, RGeo::Geographic.spherical_factory(:srid => 4326))

  def DT_RowId
    self.id
  end

  def geo
    return RGeo::GeoJSON.encode(self.location)
  end

  def geojson
    s = self.attributes.delete_if {|key, value| ["location","id"].include?(key) }
    return RGeo::GeoJSON::Feature.new(self.location, self.id, s)
  end

  def latitude
    location.latitude
  end

  def longitude
    location.longitude
  end

end
